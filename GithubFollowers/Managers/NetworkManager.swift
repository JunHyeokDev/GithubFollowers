//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/9/24.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let _baseURL = "https://api.github.com"
    private let _followersPerPage = "20"
    
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
}
