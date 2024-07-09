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
    
    func getFollowers(for username:String, page: Int, completed: @escaping([Follower]?, String?) -> Void ) {
        let endpoint = baseURL + "/users/\(username)/followers?per_page=\(followersPerPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(nil,"This username created an invalid request. Please try again")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error { completed(nil, "Unable to complete your request. Please Check your internet connection") }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invalid response from the server. Please try again.")
                return
            }
            
            guard let data = data else {
                completed(nil, "The data received from the server was invaild. Please try again.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data) // [Follower].self ??
                completed(followers,nil) // Good to go
            } catch {
                completed(nil, "Invalid response from the server. Please try again.")
            }
        }
        task.resume() // This is what really makes the netwroking job
    }
}
