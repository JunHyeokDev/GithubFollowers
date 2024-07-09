//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/9/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com"
    let followersPerPage = "100"
    private init() {}
    
    func getFollowers(for username:String, page: Int, completed: @escaping([Follower]?, ErrorMessage?) -> Void ) {
        let endpoint = baseURL + "/users/\(username)/followers?per_page=\(followersPerPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(nil, .invalidUsername)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error { completed(nil, .unableToComplete) }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, .invalidReponse)
                return
            }
            
            guard let data = data else {
                completed(nil, .invalidData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data) // [Follower].self ??
                completed(followers,nil) // Good to go
            } catch {
//                completed(nil,error.localizedDescription) // It's good for debug, but not for user!
                completed(nil, .invalidData)
            }
        }
        task.resume() // This is what really makes the netwroking job
    }
}
