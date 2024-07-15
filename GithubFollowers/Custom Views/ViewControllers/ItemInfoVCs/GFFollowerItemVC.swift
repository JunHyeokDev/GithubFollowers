//
//  GFFollowerItemVC.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/10/24.
//

import UIKit

// MARK: - Protocol : GFFollowerItemVCDelegate
protocol GFFollowerItemVCDelegate : AnyObject {
    func didTapGetFollowers(for user : User)
}

class GFFollowerItemVC: GFItemInfoVC {
    
    weak var delegate : GFFollowerItemVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    init(user: User, delegate : GFFollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for : user)
    }
}
