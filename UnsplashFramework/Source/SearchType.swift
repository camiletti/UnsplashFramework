//
//  SearchType.swift
//  UnsplashFramework
//
//  Created by Pablo on 21/01/2018.
//  Copyright © 2018 Pablo Camiletti. All rights reserved.
//

/// Representation of the available items that can be searched
enum SearchType {
    /// Search of photos
    case photo
    /// Search of collections
    case collection
    /// Search of users
    case user

    // MARK: - Properties

    /// Extension to get the endpoint for a type of search
    var endpoint: Endpoint {
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
