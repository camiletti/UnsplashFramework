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

public struct UNTopic: Decodable {

    // MARK: - Declarations

    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case title
        case description
        case publishedDate = "published_at"
        case updateDate = "updated_at"
        case startDate = "starts_at"
        case endDate = "ends_at"
        case onlySubmissionsAfterDate = "only_submissions_after"
        case visibility
        case isFeatured = "featured"
        case totalPhotos = "total_photos"
        case apiLocations = "links"
        case status
        case owners
        case topContributors = "top_contributors"
        case coverPhoto = "cover_photo"
        case previewPhotos = "preview_photos"

        // Unknown properties (found to always come empty/null):
        // case currentUserContributions = "current_user_contributions"
        // case totalCurrentUserSubmissions = "total_current_user_submissions"
    }

    public enum Visibility: String, Decodable {
        case featured
        case visible
    }

    public enum Status: String, Decodable {
        case open
    }

    // MARK: - Declarations

    /// Unique identifier of the topic.
    public let id: String

    /// The slug name of the topic.
    public let slug: String

    /// The title of the topic.
    public let title: String

    /// The description of the topic.
    public let description: String

    /// Date when the topic was published.
    public let publishedDate: Date

    /// Date the topic was updated.
    public let updateDate: Date?

    /// The date from which the topic starts.
    public let startDate: Date?

    /// The at which the topic will be removed.
    public let endDate: Date?

    /// Whether submissions are restricted after a give date.
    public let onlySubmissionsAfterDate: Date?

    /// What is the current visibility of the topic.
    public let visibility: Visibility?

    /// Whether the topic is being featured.
    public let isFeatured: Bool

    /// The total number of photos participating in the topic.
    public let totalPhotos: Int

    /// API locations.
    public let apiLocations: UNTopicAPILocations

    /// The status of the topic.
    public let status: Status?

    /// The users that own the topic.
    public let owners: [UNUser]

    /// The users who contributed the most.
    public let topContributors: [UNUser]?

    /// The cover photo representing the topic.
    public let coverPhoto: UNPhoto

    /// A few photos as preview of the topic.
    public let previewPhotos: [UNBasicPhoto]
}
