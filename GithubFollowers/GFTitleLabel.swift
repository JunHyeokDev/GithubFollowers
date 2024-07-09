//
//  GFTitleLabel.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/9/24.
//

import UIKit

class GFTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment, fontsize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontsize, weight: .bold)
        configure()
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
