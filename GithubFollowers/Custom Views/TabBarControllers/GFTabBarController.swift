//
//  GFTabBarController.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/13/24.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(),createFavoritesNC()]
        // Do any additional setup after loading the view.
    }
    
    func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0) // Zero is left
        return UINavigationController(rootViewController: searchVC);
    }
    
    func createFavoritesNC() -> UINavigationController {
        let favoritesNC = FavoritesListVC()
        favoritesNC.title = "Favorites"
        favoritesNC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoritesNC)
    }
}
