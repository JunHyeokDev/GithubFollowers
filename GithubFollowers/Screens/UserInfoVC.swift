//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/9/24.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var username : String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        self.navigationItem.rightBarButtonItem = doneButton
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let user):
                print(user)
            case .failure(let err):
                self.presentGFALertOnMainThread(title: "Something went wrong..", message: err.localizedDescription, buttonTitle: "Got it!")
            }
        }
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }

}
