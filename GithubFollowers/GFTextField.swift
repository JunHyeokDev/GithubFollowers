//
//  GFTextField.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/8/24.
//

import UIKit

class GFTextField: UITextField {
    
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
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label // depends on dark mode!
        tintColor = .label // depends on dark mode!
        textAlignment = .center
        
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType = .go
        placeholder = "누구를 검색할까요???"
    }
}


extension SearchVC : UITextFieldDelegate {
    
}
