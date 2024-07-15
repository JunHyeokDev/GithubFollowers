//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/9/24.
//

import UIKit

// MARK: - Protocol
protocol UserInfoVCVCDelegate: AnyObject {
    func didRequestFollowers(for username : String)
}

// MARK: - UserInfoVC
class UserInfoVC: GFDataLoadingVC {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews: [UIView] = []
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    var username : String!
    weak var delegate : UserInfoVCVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        layoutUI()
        configureScrollView()
        getUserInfo()
    }
    
    
    // MARK: - Actions
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let user):
                DispatchQueue.main.async{
                    self.configureUIElements(with: user)
                }
            case .failure(let err):
                self.presentGFALertOnMainThread(title: "Something went wrong..", message: err.localizedDescription, buttonTitle: "Got it!")
            }
        }
    }
    // MARK: - UI Configure
    
    func configureUIElements(with user: User) {
        
        let repoItemVC = GFRepoItemVC(user: user,delegate: self)
        let followerItemVC = GFFollowerItemVC(user: user, delegate: self)
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewTwo)
        self.add(childVC: followerItemVC, to: self.itemViewOne)
        self.dateLabel.text = "Github Since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    func layoutUI() {
        
        let padding : CGFloat = 20
        let itemHeight: CGFloat = 140
        
        
         itemViews = [headerView,itemViewOne, itemViewTwo,dateLabel]
        for itemView in itemViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }

}


extension UserInfoVC : GFRepoItemVCDelegate {
    func didTapGithubProfile(for user: User) {
        // Show Safari VC
        guard let url = URL(string: user.htmlUrl) else {
            presentGFALertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Ok..!")
            return
        }
        presentSafariVC(with: url)
    }
    
}
extension UserInfoVC : GFFollowerItemVCDelegate {
    func didTapGetFollowers(for user : User) {
        // dismiss VC
        // tell follower list screen the new user
        guard user.followers != 0 else {
            presentGFALertOnMainThread(title: "No followers..!", message: "This user has no followers yet..😿", buttonTitle: "Ok..")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}
