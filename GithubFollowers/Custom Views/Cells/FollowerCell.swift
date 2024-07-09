//
//  FollowerCell.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/9/24.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let reuseID = "FollowerCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel   = GFTitleLabel(textAlignment: .center, fontsize: 16)
    
    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configure
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        let padding : CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    // MARK: - Actions
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        //avatarImageView.image = Image(
    }

}
