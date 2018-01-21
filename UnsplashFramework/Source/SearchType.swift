//
//  SearchType.swift
//  UnsplashFramework
//
//  Created by Pablo on 21/01/2018.
//  Copyright © 2018 Pablo Camiletti. All rights reserved.
//

import Foundation


/// Representation of the available items that can be searched
internal enum SearchType
{
    /// Search of photos
    case photo
    
    /// Search of collections
    case collection
    
    /// Search of users
    case user
}


extension SearchType
{
    /// Extension to get the endpoint for a type of search
    var endpoint: Endpoint
    {
        switch self {
        case .photo:
            return .photoSearch
        case .collection:
            return .collectionSearch
        case .user:
            return .userSearch
        }
    }
}
