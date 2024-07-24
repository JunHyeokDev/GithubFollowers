//
//  Follower.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/9/24.
//

import Foundation


struct Follower : Codable, Hashable {
    var login: String
    var avatarUrl : String // avatar_url -> avatarUrl
    
//    Just for little bit Optimization!
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(login)
//    }
}
