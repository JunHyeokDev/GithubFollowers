//
//  GFRepoItemVC.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/10/24.
//

import UIKit

// MARK: - Protocol : GFRepoItemVCDelegate
protocol GFRepoItemVCDelegate : AnyObject {
    func didTapGithubProfile(for user : User)
}


class GFRepoItemVC: GFItemInfoVC {
    
    weak var delegate : GFRepoItemVCDelegate!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGithubProfile(for: user)
    }
}
