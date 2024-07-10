//
//  GFRepoItemVC.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/10/24.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
}
