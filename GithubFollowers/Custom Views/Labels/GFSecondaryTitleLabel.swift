//
//  GFSecondaryTitleLabel.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/9/24.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    // MARK: - UI Configure
    private func configure() {
        textColor = .secondaryLabel // pretty gray color
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail // ItIt'stoolong....
        translatesAutoresizingMaskIntoConstraints = false
    }

}
