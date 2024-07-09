//
//  ErrorMessage.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/9/24.
//

import Foundation

enum GFError : String, Error {
    case invalidUsername = "This username created an invalid request. Please try again"
    case unableToComplete = "Unable to complete your request. Please Check your internet connection"
    case invalidReponse = "Invalid response from the server. Please try again."
    case invalidData  = "The data received from the server was invaild. Please try again."
}
