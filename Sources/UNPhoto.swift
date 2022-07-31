//
//  UFPhoto.swift
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

/// Holds all the information about a photo.
public struct UNPhoto: Decodable, Identifiable {

    // MARK: - Declarations

    enum CodingKeys: String, CodingKey {
        case id
        case creationDate = "created_at"
        case updateDate = "updated_at"
        case width
        case height
        case hexColor = "color"
        case numberOfLikes = "likes"
        case isLikedByUser = "liked_by_user"
        case description
        case user
        case collections = "current_user_collections"
        case categories
        case imageLinks = "urls"
        case apiLocations = "links"
    }

    // MARK: - Properties

    /// Unique identifier of the photo.
    public var id: String

    /// Date the photo was created.
    public var creationDate: Date?

    /// Date the photo was updated.
    public var updateDate: Date?

    /// Width of the photo in pixels.
    public var width: Int

    /// Height of the photo in pixels.
    public var height: Int

    /// Representative color of the photo in hex value.
    public var hexColor: String

    /// Number of likes the photo has.
    public var numberOfLikes: Int

    /// Whether the user liked their own photo or not.
    public var isLikedByUser: Bool

    /// Description of the photo.
    public var description: String?

    /// The user that owns the photo.
    public var user: UNUser

    /// The collections the photo belongs to.
    public var collections: [UNCollection]

    /// Categories associated to the photo.
    public var categories: [UNCategory]

    /// Links to the different size of the photo.
    internal var imageLinks: UNPhotoImageLinks

    /// The locations related to the photo.
    public var apiLocations: UNPhotoAPILocations

    // MARK: - Life Cycle

    init(id: String, creationDate: Date?, updateDate: Date?, width: Int, height: Int, hexColor: String, numberOfLikes: Int, isLikedByUser: Bool, description: String?, user: UNUser, collections: [UNCollection], categories: [UNCategory], imageLinks: UNPhotoImageLinks, apiLocations: UNPhotoAPILocations) {
        self.id = id
        self.creationDate = creationDate
        self.updateDate = updateDate
        self.width = width
        self.height = height
        self.hexColor = hexColor
        self.numberOfLikes = numberOfLikes
        self.isLikedByUser = isLikedByUser
        self.description = description
        self.user = user
        self.collections = collections
        self.categories = categories
        self.imageLinks = imageLinks
        self.apiLocations = apiLocations
    }

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameter decoder: Swift's decoder.
    /// - Throws: If a value that is non-optional is missing the function will throw.
    public init(from decoder: Decoder) throws {
        // Decode each value
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        creationDate = try? values.decode(Date.self, forKey: .creationDate)
        updateDate = try? values.decode(Date.self, forKey: .updateDate)
        width  = try values.decode(Int.self, forKey: .width)
        height = try values.decode(Int.self, forKey: .height)
        hexColor = try values.decode(String.self, forKey: .hexColor)
        numberOfLikes = try values.decode(Int.self, forKey: .numberOfLikes)
        isLikedByUser = try values.decode(Bool.self, forKey: .isLikedByUser)
        description = try? values.decode(String.self, forKey: .description)
        user = try values.decode(UNUser.self, forKey: .user)
        collections = (try? values.decode([UNCollection].self, forKey: .collections)) ?? [UNCollection]()
        categories = (try? values.decode([UNCategory].self, forKey: .categories)) ?? [UNCategory]()
        imageLinks = try values.decode(UNPhotoImageLinks.self, forKey: .imageLinks)
        apiLocations = try values.decode(UNPhotoAPILocations.self, forKey: .apiLocations)
    }
}

// MARK: - Equatable
extension UNPhoto: Equatable {

    /// Returns a Boolean value indicating whether two photos represent the same photo.
    ///
    /// Discussion: Two photos are considered to be the same if they represent the
    /// same photo; that is, if they have the same id, regardless if
    /// the other variables are different.
    public static func == (lhs: UNPhoto, rhs: UNPhoto) -> Bool {
        lhs.id == rhs.id
    }

    /// Returns a Boolean value indicating whether the two photos don't represent the same photo.
    public static func != (lhs: UNPhoto, rhs: UNPhoto) -> Bool {
        !(lhs == rhs)
    }
}

// MARK: - Hashable
extension UNPhoto: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
