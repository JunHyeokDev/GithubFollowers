//
//  UITableView+Ext.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/14/24.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
    
}
