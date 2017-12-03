//
//  UNUser.swift
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


import Foundation


/// Holds all the information about a user.
public struct UNUser: Decodable
{
    
    // MARK: - Properties
    
    /// User's unique identifier.
    public   var id                : String
    
    /// The username of the user.
    public   var username          : String
    
    /// The name of the user.
    public   var name              : String?
    
    /// The first name of the user if it has one set.
    public   var firstName         : String?
    
    /// The last name of the user if it has one set.
    public   var lastName          : String?
    
    /// The twitter username of the user if it has one set.
    public   var twitterUsername   : String?
    
    /// The url to the user's portfolio if it has one set.
    public   var portfolioURL      : URL?
    
    /// The user's bio if it has one set.
    public   var bio               : String?
    
    /// The user's location if it has one set.
    public   var location          : String?
    
    /// Number of photos the user liked.
    public   var totalLikes        : Int
    
    /// Number of photos the user has uploaded.
    public   var totalPhotos       : Int
    
    /// Number of collections the user has.
    public   var totalCollections  : Int
    
    /// URLs to the different sizes of the user's profile image.
    public   var profileImageLinks : UNProfileImageLinks
    
    /// The different API locations Unsplash offers.
    internal var apiLocations      : UNUserAPILocations
    
    /// Public URL to the user's profile.
    public var profileURL          : URL
    {
        return self.apiLocations.externalProfileURL
    }
    
    
    /// Codable poperty mapping.
    internal enum CodingKeys: String, CodingKey
    {
        case id                = "id"
        case username          = "username"
        case name              = "name"
        case firstName         = "first_name"
        case lastName          = "last_name"
        case twitterUsername   = "twitter_username"
        case portfolioURL      = "portfolio_url"
        case bio               = "bio"
        case location          = "location"
        case totalLikes        = "total_likes"
        case totalPhotos       = "total_photos"
        case totalCollections  = "total_collections"
        case profileImageLinks = "profile_image"
        case apiLocations      = "links"
    }
}


extension UNUser: Equatable
{
    /// Returns a Boolean value indicating whether two users represent the same user.
    ///
    /// Two users are considered to be the same if they represent the
    /// same user; that is, if they have the same id, regardless if
    /// the other variables are different.
    public static func ==(lhs: UNUser, rhs: UNUser) -> Bool
    {
        return lhs.id == rhs.id
    }
    
    
    /// Returns a Boolean value indicating whether two users don't represent the same user.
    public static func !=(lhs: UNUser, rhs: UNUser) -> Bool
    {
        return !(lhs == rhs)
    }
}
