//
//  UIHelper.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/9/24.
//

import UIKit

// Enum or Struct?
struct UIHelper {
    
    static func createThreeColumFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding : CGFloat = 12
        let minimumItemSpacing : CGFloat = 10
        let availableWidth = width - (padding*2) - (minimumItemSpacing*2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40) // compensate the text area
                
        return flowLayout
    }
    
}
