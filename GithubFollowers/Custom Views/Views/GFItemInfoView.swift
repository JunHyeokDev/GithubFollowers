//
//  GFItemInfoView.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/10/24.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}

class GFItemInfoView: UIView {
    
    let symbolImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontsize: 14)
    let countLabel = GFTitleLabel(textAlignment: .center, fontsize: 14)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let symbolSize : CGFloat = 20
        
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: symbolSize),
            symbolImageView.heightAnchor.constraint(equalToConstant: symbolSize),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18),
            
        ])
    }
    
    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            symbolImageView.image = UIImage(systemName: SFSymbols.repos)
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImageView.image = UIImage(systemName: SFSymbols.gists)
            titleLabel.text = "Public Gists"
        case .followers:
            symbolImageView.image = UIImage(systemName: SFSymbols.followers)
            titleLabel.text = "Followers"
        case .following:
            symbolImageView.image = UIImage(systemName: SFSymbols.following)
            titleLabel.text = "Following"
        }
        countLabel.text = String(count)
    }

}
