//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/9/24.
//

import UIKit

class GFAvatarImageView: UIImageView {

    // MARK: - Properties
    let placeholderImage = UIImage(named: "avatar-placeholder")!
    
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
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self]  data, reponse, error in
            
            guard let self = self else {return}
            if let err = error {
                return
            }
            guard let data = data else { return }
            guard let response = reponse as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        task.resume()
    }

}
