//
//  UNCollection.swift
//  UnsplashFramework
//
//  Copyright 2017 Pablo Camiletti
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


import UIKit


/// Holds all the information about a collection.
public struct UNCollection
{
    
    // MARK: - Properties
    
    /// The unique identifier of the collection.
    public   var id            : Int
    
    /// The title of the collection.
    public   var title         : String?
    
    /// Date when the collection was published.
    public   var publishedDate : Date?
    
    /// Date when the collection was last updated.
    public   var updatedDate   : Date?
    
    /// Boolean value indicating whether the collection is curated.
    public   var isCurated     : Bool
    
    /// Cover photo of the collection.
    public   var coverPhoto    : UNPhoto?
    
    /// User that owns the collection.
    public   var user          : UNUser
    
    /// API locations.
    internal var apiLocations  : UNCollectionAPILocations
    
    
    /// Codable poperty mapping.
    internal enum CodingKeys: String, CodingKey
    {
        case id            = "id"
        case title         = "title"
        case publishedDate = "published_at"
        case updatedDate   = "updated_at"
        case isCurated     = "curated"
        case coverPhoto    = "cover_photo"
        case user          = "user"
        case apiLocations  = "links"
    }
}


extension UNCollection: Decodable
{
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameter decoder: Swift's decoder.
    /// - Throws: If a value that is non-optional is missing the function will throw.
    public init(from decoder: Decoder) throws
    {
        // Create date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = ResponseDateFormat
        
        // Decode each value
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.title = try? values.decode(String.self, forKey: .title)
        if let publishedDateString = try? values.decode(String.self, forKey: .publishedDate)
        {
            self.publishedDate = dateFormatter.date(from: publishedDateString)
        }
        if let updatedDateString = try? values.decode(String.self, forKey: .updatedDate)
        {
            self.updatedDate = dateFormatter.date(from: updatedDateString)
        }
        self.isCurated = try values.decode(Bool.self, forKey: .isCurated)
        self.coverPhoto = try? values.decode(UNPhoto.self, forKey: .coverPhoto)
        self.user = try values.decode(UNUser.self, forKey: .user)
        self.apiLocations = try values.decode(UNCollectionAPILocations.self, forKey: .apiLocations)
    }
}


extension UNCollection: Equatable
{
    
    /// Returns a Boolean value indicating whether the two collections represent the same collection.
    ///
    /// Discussion: Two collections are considered to be the same if they represent
    /// the same collection; that is, if they have the same id, regardless
    /// if the other variables are different.
    public static func ==(lhs: UNCollection, rhs: UNCollection) -> Bool
    {
        return lhs.id == rhs.id
    }
    
    
    /// Returns a Boolean value indicating whether two collections don't represent the same collection.
    public static func !=(lhs: UNCollection, rhs: UNCollection) -> Bool
    {
        return !(lhs == rhs)
    }
}
