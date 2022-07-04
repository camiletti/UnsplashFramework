//
//  UNUserAPILocations.swift
//  UnsplashFramework
//
//  Copyright 2021 Pablo Camiletti
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished
//  to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
//  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
//  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import Foundation

/// Holds the API URLs for a user.
struct UNUserAPILocations: Decodable {

    // MARK: - Declarations

    enum CodingKeys: String, CodingKey {
        case apiProfileURL = "self"
        case apiPhotosURL = "photos"
        case apiLikesURL = "likes"
        case apiPortfolioURL = "portfolio"
        case apiFollowingURL = "following"
        case apiFollowersURL = "followers"
        case externalProfileURL = "html"
    }

    // MARK: - Properties

    /// User's profile URL. Accessible through the API.
    var apiProfileURL: URL

    /// User's photos URL. Accessible only through the API.
    var apiPhotosURL: URL

    /// User's likes URL. Accessible only through the API.
    var apiLikesURL: URL

    /// User's portfolio URL. Accessible only through the API.
    var apiPortfolioURL: URL

    /// Other users this user is following. Accessible only through the API.
    var apiFollowingURL: URL?

    /// Followers of the user. Accessible only through the API.
    var apiFollowersURL: URL?

    /// User's public profile URL.
    var externalProfileURL: URL
}

// MARK: - Equatable
extension UNUserAPILocations: Equatable {

    /// Returns a Boolean value indicating whether the two UNUserAPILocations have the same
    /// value for their variables.
    static func == (lhs: UNUserAPILocations, rhs: UNUserAPILocations) -> Bool {
        lhs.apiProfileURL == rhs.apiProfileURL &&
            lhs.apiPhotosURL == rhs.apiPhotosURL &&
            lhs.apiLikesURL == rhs.apiLikesURL &&
            lhs.apiPortfolioURL == rhs.apiPortfolioURL &&
            lhs.apiFollowingURL == rhs.apiFollowingURL &&
            lhs.apiFollowersURL == rhs.apiFollowersURL &&
            lhs.externalProfileURL == rhs.externalProfileURL
    }

    /// Returns a Boolean value indicating whether the two UNUserAPILocations have at least
    /// one value different.
    static func != (lhs: UNUserAPILocations, rhs: UNUserAPILocations) -> Bool {
        !(lhs == rhs)
    }
}
