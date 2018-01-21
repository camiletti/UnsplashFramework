//
//  SearchType.swift
//  UnsplashFramework
//
//  Created by Pablo on 21/01/2018.
//  Copyright © 2018 Pablo Camiletti. All rights reserved.
//

import Foundation


enum SearchType
{
    case photo
    case collection
    case user
}


extension SearchType
{
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
