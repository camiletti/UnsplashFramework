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

/// Holds all the information about a photo.
public class UNPhoto: UNBasicPhoto {

    // MARK: - Declarations

    enum CodingKeys: String, CodingKey {
        case promotedDate = "promoted_at"
        case width
        case height
        case hexColor = "color"
        case description
        case altDescription = "alt_description"
        case numberOfLikes = "likes"
        case isLikedByUser = "liked_by_user"
        case user
        case collections = "current_user_collections"
        case categories
        case statistics
        case apiLocations = "links"
    }

    // MARK: - Properties

    /// Date the photo was promoted.
    public let promotedDate: Date?

    /// Width of the photo in pixels.
    public let width: Int

    /// Height of the photo in pixels.
    public let height: Int

    /// Representative color of the photo in hex value.
    public let hexColor: String

    /// Description of the photo.
    public let description: String?

    /// The accessible description of the photo.
    public let altDescription: String?

    /// Number of likes the photo has.
    public let numberOfLikes: Int

    /// Whether the user liked their own photo or not.
    public let isLikedByUser: Bool

    /// The user that owns the photo.
    public let user: UNUser

    /// The collections the photo belongs to.
    public let collections: [UNCollection]

    /// Categories associated to the photo.
    public let categories: [UNCategory]

    /// The statistics of the photos
    /// Notes:
    /// - They are optional as they will be returned if requested.
    /// - Only some requests can return this property.
    public let statistics: UNPhotoStatistics?

    /// The locations related to the photo.
    public let apiLocations: UNPhotoAPILocations

    // MARK: - Life Cycle

    init(id: String,
         creationDate: Date?,
         updateDate: Date?,
         promotedDate: Date?,
         width: Int,
         height: Int,
         hexColor: String,
         blurHash: String,
         description: String?,
         altDescription: String?,
         numberOfLikes: Int,
         isLikedByUser: Bool,
         user: UNUser,
         collections: [UNCollection],
         categories: [UNCategory],
         statistics: UNPhotoStatistics?,
         imageURLs: UNPhotoImageURLs,
         apiLocations: UNPhotoAPILocations) {
        self.promotedDate = promotedDate
        self.width = width
        self.height = height
        self.hexColor = hexColor
        self.description = description
        self.altDescription = altDescription
        self.numberOfLikes = numberOfLikes
        self.isLikedByUser = isLikedByUser
        self.user = user
        self.collections = collections
        self.categories = categories
        self.statistics = statistics
        self.apiLocations = apiLocations
        super.init(id: id, creationDate: creationDate, updateDate: updateDate, blurHash: blurHash, imageURLs: imageURLs)
    }

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameter decoder: Swift's decoder.
    /// - Throws: If a value that is non-optional is missing the function will throw.
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        promotedDate = try? values.decode(Date.self, forKey: .promotedDate)
        width  = try values.decode(Int.self, forKey: .width)
        height = try values.decode(Int.self, forKey: .height)
        hexColor = try values.decode(String.self, forKey: .hexColor)
        description = try? values.decode(String.self, forKey: .description)
        altDescription = try? values.decode(String.self, forKey: .altDescription)
        numberOfLikes = try values.decode(Int.self, forKey: .numberOfLikes)
        isLikedByUser = try values.decode(Bool.self, forKey: .isLikedByUser)
        user = try values.decode(UNUser.self, forKey: .user)
        collections = (try? values.decode([UNCollection].self, forKey: .collections)) ?? [UNCollection]()
        categories = (try? values.decode([UNCategory].self, forKey: .categories)) ?? [UNCategory]()
        statistics = try? values.decode(UNPhotoStatistics.self, forKey: .statistics)
        apiLocations = try values.decode(UNPhotoAPILocations.self, forKey: .apiLocations)

        try super.init(from: decoder)
    }
}
