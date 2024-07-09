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
    let cache = NetworkManager.shared.cache
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
    
    
    // MARK: - Action
    func downloadImage(from urlString: String) -> Void {
        
        //let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: urlString as NSString) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self]  data, reponse, error in
            
            guard let self = self else {return}
            if error != nil {
                return
            }
            guard let data = data else { return }
            guard let response = reponse as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let image = UIImage(data: data) else { return }
            
            self.cache.setObject(image, forKey: urlString as NSString)
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        task.resume()
    }

}
