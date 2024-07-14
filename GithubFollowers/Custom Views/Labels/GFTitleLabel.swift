//
//  GFTitleLabel.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/9/24.
//

import UIKit

class GFTitleLabel: UILabel {
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontsize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontsize, weight: .bold)
    }
    // MARK: - UI Configure
    private func configure() {
        textColor = .label // Remember, It's System color!
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail // If the name is too wrong, It becomes like "myLongNameis......"
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
