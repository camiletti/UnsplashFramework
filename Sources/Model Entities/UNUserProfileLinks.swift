//  Copyright Pablo Camiletti
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

public struct UNUserProfileLinks: Codable, Equatable {

    // MARK: - Declarations

    enum CodingKeys: String, CodingKey {
        case profileURL = "html"
        case apiProfileURL = "self"
        case apiPhotosURL = "photos"
        case apiLikesURL = "likes"
        case apiPortfolioURL = "portfolio"
        case apiFollowingURL = "following"
        case apiFollowersURL = "followers"
    }

    // MARK: - Properties

    /// URL of the html version of the profile.
    public let profileURL: URL

    /// API URL for the user's profile.
    let apiProfileURL: URL

    /// API URL for the photos of the user's.
    let apiPhotosURL: URL

    /// API URL for the likes of the user.
    let apiLikesURL: URL

    /// API URL for the user's Unsplash portfolio.
    let apiPortfolioURL: URL

    /// API URL for the accounts the user is following.
    let apiFollowingURL: URL

    /// API URL for the accounts that follow the user.
    let apiFollowersURL: URL
}
