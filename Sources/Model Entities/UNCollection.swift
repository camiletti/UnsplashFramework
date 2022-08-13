//
//  UNCollection.swift
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

/// Holds all the information about a collection.
public struct UNCollection: Decodable, Identifiable {

    // MARK: - Declarations

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case publishedDate = "published_at"
        case updatedDate = "updated_at"
        case isCurated = "curated"
        case coverPhoto = "cover_photo"
        case user
        case apiLocations = "links"
    }

    // MARK: - Properties

    /// The unique identifier of the collection.
    public var id: String

    /// The title of the collection.
    public var title: String?

    /// Date when the collection was published.
    public var publishedDate: Date?

    /// Date when the collection was last updated.
    public var updatedDate: Date?

    /// Boolean value indicating whether the collection is curated.
    public var isCurated: Bool

    /// Cover photo of the collection.
    public var coverPhoto: UNPhoto?

    /// User that owns the collection.
    public var user: UNUser?

    /// API locations.
    var apiLocations: UNCollectionAPILocations

    // MARK: - Life Cycle

    init(id: String, title: String?, publishedDate: Date?, updatedDate: Date?, isCurated: Bool, coverPhoto: UNPhoto?, user: UNUser?, apiLocations: UNCollectionAPILocations) {
        self.id = id
        self.title = title
        self.publishedDate = publishedDate
        self.updatedDate = updatedDate
        self.isCurated = isCurated
        self.coverPhoto = coverPhoto
        self.user = user
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
        publishedDate = try? values.decode(Date.self, forKey: .publishedDate)
        updatedDate = try? values.decode(Date.self, forKey: .updatedDate)
        isCurated = try values.decode(Bool.self, forKey: .isCurated)
        coverPhoto = try? values.decode(UNPhoto.self, forKey: .coverPhoto)
        user = try? values.decode(UNUser.self, forKey: .user)
        apiLocations = try values.decode(UNCollectionAPILocations.self, forKey: .apiLocations)
    }
}

// MARK: - Equatable
extension UNCollection: Equatable {

    /// Returns a Boolean value indicating whether the two collections represent the same collection.
    ///
    /// Discussion: Two collections are considered to be the same if they represent
    /// the same collection; that is, if they have the same id, regardless
    /// if the other variables are different.
    public static func == (lhs: UNCollection, rhs: UNCollection) -> Bool {
        lhs.id == rhs.id
    }

    /// Returns a Boolean value indicating whether two collections don't represent the same collection.
    public static func != (lhs: UNCollection, rhs: UNCollection) -> Bool {
        !(lhs == rhs)
    }
}
