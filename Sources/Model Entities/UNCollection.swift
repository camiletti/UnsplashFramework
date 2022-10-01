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

/// Holds all the information about a collection.
public struct UNCollection: Decodable, Identifiable {

    // MARK: - Declarations

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case publishedDate = "published_at"
        case lastCollectedDate = "last_collected_at"
        case updatedDate = "updated_at"
        case isCurated = "curated"
        case isPrivate = "private"
        case wasFeatured = "featured"
        case totalAmountOfPhotos = "total_photos"
        case coverPhoto = "cover_photo"
        case previewPhotos = "preview_photos"
        case tags
        case user
        case apiLocations = "links"
        case shareKey = "share_key"
    }

    // MARK: - Properties

    /// The unique identifier of the collection.
    public let id: String

    /// The title of the collection.
    public let title: String?

    /// The description of the collection.
    public let description: String?

    /// Date when the collection was published.
    public let publishedDate: Date?

    /// Date when the last photo was added.
    public let lastCollectedDate: Date?

    /// Date when the collection was last updated.
    public let updatedDate: Date?

    /// Boolean value indicating whether the collection is curated.
    public let isCurated: Bool

    /// Whether the collection was ever featured.
    public let wasFeatured: Bool

    /// The total number of photos in the collection.
    public let totalAmountOfPhotos: Int

    /// Whether the collection is private to the user.
    public let isPrivate: Bool

    /// Cover photo of the collection.
    public let coverPhoto: UNPhoto?

    /// A small amount of photos that belong to the collection.
    /// Normally a maximum 4.
    public let previewPhotos: [UNBasicPhoto]

    /// The tags that the collection is about or contains.
    public let tags: [UNTag]

    /// User that owns the collection.
    public let user: UNUser?

    public let shareKey: String

    /// API locations.
    let apiLocations: UNCollectionAPILocations

    // MARK: - Life Cycle

    init(id: String,
         title: String?,
         description: String?,
         publishedDate: Date?,
         lastCollectedDate: Date?,
         updatedDate: Date?,
         isCurated: Bool,
         isPrivate: Bool,
         wasFeatured: Bool,
         totalAmountOfPhotos: Int,
         coverPhoto: UNPhoto?,
         previewPhotos: [UNPhoto],
         tags: [UNTag],
         user: UNUser?,
         shareKey: String,
         apiLocations: UNCollectionAPILocations) {
        self.id = id
        self.title = title
        self.description = description
        self.publishedDate = publishedDate
        self.lastCollectedDate = lastCollectedDate
        self.updatedDate = updatedDate
        self.isCurated = isCurated
        self.isPrivate = isPrivate
        self.wasFeatured = wasFeatured
        self.totalAmountOfPhotos = totalAmountOfPhotos
        self.coverPhoto = coverPhoto
        self.previewPhotos = previewPhotos
        self.tags = tags
        self.user = user
        self.shareKey = shareKey
        self.apiLocations = apiLocations
    }

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameter decoder: Swift's decoder.
    /// - Throws: If a value that is non-optional is missing the function will throw.
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        title = try? values.decode(String.self, forKey: .title)
        description = try? values.decode(String.self, forKey: .description)
        publishedDate = try? values.decode(Date.self, forKey: .publishedDate)
        lastCollectedDate = try? values.decode(Date.self, forKey: .lastCollectedDate)
        updatedDate = try? values.decode(Date.self, forKey: .updatedDate)
        isCurated = (try? values.decode(Bool.self, forKey: .isCurated)) ?? false
        isPrivate = (try? values.decode(Bool.self, forKey: .isPrivate)) ?? false
        wasFeatured = (try? values.decode(Bool.self, forKey: .wasFeatured)) ?? false
        totalAmountOfPhotos = try values.decode(Int.self, forKey: .totalAmountOfPhotos)
        coverPhoto = try? values.decode(UNPhoto.self, forKey: .coverPhoto)
        previewPhotos = (try? values.decode([UNBasicPhoto].self, forKey: .previewPhotos)) ?? []
        tags = try values.decode([UNTag].self, forKey: .tags)
        user = try? values.decode(UNUser.self, forKey: .user)
        shareKey = try values.decode(String.self, forKey: .shareKey)
        apiLocations = try values.decode(UNCollectionAPILocations.self, forKey: .apiLocations)
    }
}
