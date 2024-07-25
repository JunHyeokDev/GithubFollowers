//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/9/24.
//

import UIKit

class NetworkManager {
    // MARK: - Singleton
    static let shared = NetworkManager()
    private let _baseURL = "https://api.github.com"
    private let _followersPerPage = "100"
    
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getFollowers(for username:String, page: Int, completed: @escaping(Result<[Follower],GFError>) -> Void ) {
        let endpoint = _baseURL + "/users/\(username)/followers?per_page=\(_followersPerPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error { completed(.failure(.unableToComplete)) }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidReponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data) // [Follower].self ??
                completed(.success(followers)) // Good to go
            } catch {
//                completed(nil,error.localizedDescription) // It's good for debug, but not for user!
                completed(.failure(.invalidData))
            }
        }
        task.resume() // This is what really makes the netwroking job
    }
    
    func getUserInfo(for username:String, completed: @escaping(Result<User,GFError>) -> Void ) {
        let endpoint = _baseURL + "/users/\(username)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error { completed(.failure(.unableToComplete)) }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidReponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601 // Standard!
                let user = try decoder.decode(User.self, from: data) // [Follower].self ??
                completed(.success(user)) // Good to go
            } catch {
//                completed(nil,error.localizedDescription) // It's good for debug, but not for user!
                completed(.failure(.invalidData))
            }
        }
        task.resume() // This is what really makes the netwroking job
    }
    
    func donwloadImage(from url: String, completed: @escaping (UIImage?) -> Void ) {
        
        let cacheKey = NSString(string: url)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: url) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self]  data, reponse, error in
            
            guard let self = self,
                    let data = data,
                  let response = reponse as? HTTPURLResponse, response.statusCode == 200,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                completed(image)
            }
        }
        
        task.resume()
    }
}
