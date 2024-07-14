//
//  GFAlertContainerView.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/14/24.
//

import UIKit

class GFAlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
       backgroundColor = .systemBackground
       layer.cornerRadius = 16
       layer.borderWidth  = 2  // Good design when it comes to DarkMode
       layer.borderColor  = UIColor.white.cgColor
       translatesAutoresizingMaskIntoConstraints = false
    }
    
    
}
