//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/9/24.
//

import UIKit

class FollowerListVC: GFDataLoadingVC {
    
    enum Section { // enum is hashable by default
        case main
    }
    
    // MARK: - Properties
    var username: String!
    var collectionView : UICollectionView!
    var dataSource : UICollectionViewDiffableDataSource<Section,Follower>!
    var followers : [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    var isLoadingMoreFollowers = false
    // MARK: - Life Cycle
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController ()
        getFollowers(username: username, page: page)
        configureDataSource()
        configureSerachController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Configure UI
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumFlowLayout(in: view))
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureViewController () {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        self.navigationItem.rightBarButtonItem = addButton
    }
    // MARK: - Actions
    @objc func addButtonTapped() {
        showLoadingView()
        isLoadingMoreFollowers = true
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            
            switch result {
            case.success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistanceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    guard let error = error else {
                        self.presentGFALertOnMainThread(title: "Success!", message: "You have successfully favorited this user!🥳", buttonTitle: "좋았쓰!!")
                        return
                    }
                    self.presentGFALertOnMainThread(title: "Something went wrong..!", message: error.rawValue, buttonTitle: "Ok")
                }
            case.failure(let error):
                self.presentGFALertOnMainThread(title: "Soemthing went wrong", message: error.rawValue, buttonTitle: "OK")
            }
            self.isLoadingMoreFollowers = false
        }
    }
    
    func configureSerachController() {
        let searchController =  UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false //
        navigationItem.searchController = searchController
    }
    
    // MARK: - Actions
    func getFollowers(username: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return } // Unowned just does unwraping the optional.
            self.dismissLoadingView()
            switch result{
            case.success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers, Go follow !"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                    }
                }
                self.updateData(on: self.followers) // Closure happens in the background thread..!
            case.failure(let err):
                self.presentGFALertOnMainThread(title: "Error..!", message: err.rawValue, buttonTitle: "Not okay..")
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { // Let's safely update it in Main Thread
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension FollowerListVC : UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("Dragging")
        let offsetY = scrollView.contentOffset.y // How far away from the top scroll ?
        let contentHeight = scrollView.contentSize.height // The Long~~ content size of all contents in the scroll
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page+=1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        let destVC = UserInfoVC()
        
        destVC.username = follower.login
        destVC.delegate = self
        let navVC = UINavigationController(rootViewController: destVC)
        present(navVC, animated: true)
        
    }
}

extension FollowerListVC : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            isSearching = false
            updateData(on: followers)
            return
        }
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
}


extension FollowerListVC : UserInfoVCVCDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        // collectionView.setContentOffset(.zero, animated: true) // reset the scroll..!
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
}
