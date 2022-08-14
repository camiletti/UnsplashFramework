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

public class UNFullPhoto: UNPhoto {

    // MARK: - Declarations

    private enum CodingKeys: String, CodingKey {
        case cameraDetails = "exif"
        case location
        case isPublicDomain = "public_domain"
        case topics = "tags"
        case relatedCollections = "related_collections"
        case numberOfViews = "views"
        case numberOfDownloads = "downloads"
    }

    private enum RelatedCollectionsCodingKeys: String, CodingKey {
        case results
    }

    // MARK: - Properties

    /// Technical details about the photo
    public let cameraDetails: UNCameraDetails?

    /// The location in which the photo was taken
    public let location: UNLocation?

    /// Whether the photo is of public domain
    public let isPublicDomain: Bool?

    /// The topics that the photos is about.
    public let topics: [UNTopic]?

    /// Suggested collections that are related to the photo
    public let relatedCollections: [UNCollection]?

    /// The total amount of times the photo was viewed
    public let numberOfViews: Int

    /// The total amount of times the photo was downloaded
    public let numberOfDownloads: Int

    // MARK: Life Cycle

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameter decoder: Swift's decoder.
    /// - Throws: If a value that is non-optional is missing the function will throw.
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        cameraDetails = try? container.decode(UNCameraDetails.self, forKey: .cameraDetails)
        location  = try? container.decode(UNLocation.self, forKey: .location)
        isPublicDomain = try? container.decode(Bool.self, forKey: .isPublicDomain)
        topics = try? container.decode([UNTopic].self, forKey: .topics)
        numberOfViews = try container.decode(Int.self, forKey: .numberOfViews)
        numberOfDownloads = try container.decode(Int.self, forKey: .numberOfDownloads)

        let relatedCollectionsContainer = try? container.nestedContainer(keyedBy: RelatedCollectionsCodingKeys.self, forKey: .relatedCollections)
        relatedCollections = try? relatedCollectionsContainer?.decode([UNCollection].self, forKey: .results)

        try super.init(from: decoder)
    }
}
