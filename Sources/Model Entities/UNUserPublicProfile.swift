//
//  UnsplashFramework
//
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

/// Holds all the information about a user's public profile.
public struct UNUserPublicProfile: Codable, Equatable {

    // MARK: - Declarations

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case firstName = "first_name"
        case lastName = "last_name"
        case lastUpdated = "updated_at"
        case bio
        case location
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case totalCollections = "total_collections"
        case isFollowedByCurrentUser = "followed_by_user"
        case isAvailableForHire = "for_hire"
        case allowsBeingMessaged = "allow_messages"
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case downloadsCount = "downloads"
        case socialProfiles = "social"
        case profileImageLinks = "profile_image"
        case badge
        case tagsTitlesOfInterest = "tags"
        case profileLinks = "links"
    }

    // MARK: - Properties

    /// User's unique identifier.
    public let id: String

    /// The username of the user.
    public let username: String

    /// The name of the user.
    public let name: String

    /// The first name of the user if it has one set.
    public let firstName: String

    /// The last name of the user if it has one set.
    public let lastName: String?

    /// Last time the user updated their profile.
    public let lastUpdated: Date

    /// The user's bio if it has one set.
    public let bio: String?

    /// The user's location if it has one set.
    public let location: String?

    /// Number of photos the user liked.
    public let totalLikes: Int

    /// Number of photos the user has uploaded.
    public let totalPhotos: Int

    /// Number of collections the user has.
    public let totalCollections: Int

    /// Whether the given user is follow by the current user.
    public let isFollowedByCurrentUser: Bool

    /// Whether the user is available to be hired
    public let isAvailableForHire: Bool

    /// Whether the user allows to be contact via Unsplash messages
    public let allowsBeingMessaged: Bool

    ///  Number of followers the user has.
    public let followersCount: Int

    ///  Number of users the give user is following.
    public let followingCount: Int

    /// Number of downloads
    public let downloadsCount: Int

    /// External social usernames and links of the user.
    public let socialProfiles: UNSocialProfiles

    /// URLs to the different sizes of the user's profile image.
    public let profileImageLinks: UNProfileImageLinks

    /// Main badge awarded to the user.
    public let badge: UNBadge?

    /// Titles of tags that the user's is interested in.
    public let tagsTitlesOfInterest: UNUserInterests

    /// Links to the user's profile.
    public let profileLinks: UNUserProfileLinks
}
