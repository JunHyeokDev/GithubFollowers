//
//  Constants.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/9/24.
//

import UIKit

enum SFSymbols {
    static let location = "mappin.and.ellipse"
    static let repos = "folder"
    static let gists = "text.alignleft"
    static let followers = "heart"
    static let following = "person.2"
}

enum Images {
    static let ghLogo = UIImage(named: "gh-logo")
}

enum DeviceTypes {
    static let idiom = UIDevice.current.userInterfaceIdiom
    static let nativeScale = UIScreen.main.nativeScale
    static let scale = UIScreen.main.scale

    // iPhone SE (1st gen), 5, 5s, 5c
    static let isiPhoneSE1stGen = idiom == .phone && ScreenSize.maxLength == 568.0

    // iPhone 6, 6s, 7, 8, SE (2nd gen), SE (3rd gen)
    static let isiPhone6_to_SE3 = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale

    // iPhone 6 Plus, 6s Plus, 7 Plus, 8 Plus
    static let isiPhone6_to_8Plus = idiom == .phone && ScreenSize.maxLength == 736.0

    // iPhone X, XS, 11 Pro, 12 Mini, 13 Mini
    static let isiPhoneX = idiom == .phone && ScreenSize.maxLength == 812.0

    // iPhone XR, 11
    static let isiPhoneXR = idiom == .phone && ScreenSize.maxLength == 896.0 && scale == 2.0

    // iPhone XS Max, 11 Pro Max
    static let isiPhoneXSMax = idiom == .phone && ScreenSize.maxLength == 896.0 && scale == 3.0

    // iPhone 12, 12 Pro, 13, 13 Pro, 14, 14 Pro
    static let isiPhone12And13 = idiom == .phone && ScreenSize.maxLength == 844.0

    // iPhone 12 Pro Max, 13 Pro Max, 14 Plus
    static let isiPhone12ProMax = idiom == .phone && ScreenSize.maxLength == 926.0

    // iPhone 14 Pro, 14 Pro Max
    static let isiPhone14Pro = idiom == .phone && ScreenSize.maxLength == 932.0 && scale == 3.0

    // iPhone 15, 15 Pro
    static let isiPhone15 = idiom == .phone && ScreenSize.maxLength == 852.0

    // iPhone 15 Plus, 15 Pro Max
    static let isiPhone15Plus = idiom == .phone && ScreenSize.maxLength == 932.0

    // iPad (Generic)
    static let isiPad = idiom == .pad && ScreenSize.maxLength >= 1024.0

    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXR || isiPhoneXSMax || isiPhone12And13 ||
               isiPhone12ProMax || isiPhone14Pro || isiPhone15 || isiPhone15Plus
    }
}

struct ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxLength = max(ScreenSize.width, ScreenSize.height)
    static let minLength = min(ScreenSize.width, ScreenSize.height)
}
