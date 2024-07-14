//
//  UIView+Ext.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/14/24.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView... ) {
        for view in views {
            addSubview(view)
        }
    }
}
