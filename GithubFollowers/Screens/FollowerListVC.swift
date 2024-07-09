//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/9/24.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section { // enum is hashable by default
        case main
    }
    
    // MARK: - Properties
    var username: String!
    var collectionView : UICollectionView!
    var dataSource : UICollectionViewDiffableDataSource<Section,Follower>!
    var followers : [Follower] = []
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController ()
        getFollowers()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Configure UI
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureViewController () {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func createThreeColumFlowLayout() -> UICollectionViewFlowLayout {
        
        let width = view.bounds.width
        let padding : CGFloat = 12
        let minimumItemSpacing : CGFloat = 10
        let availableWidth = width - (padding*2) - (minimumItemSpacing*2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40) // compensate the text area
                
        return flowLayout
    }
    
    // MARK: - Actions
    func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            switch result{
            case.success(let followers):
                self.followers = followers
                self.updateData() // Closure happens in the background thread..!
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
    
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
