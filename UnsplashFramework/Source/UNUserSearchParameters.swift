//
//  UNUserSearchParameters.swift
//  UnsplashFramework
//
//  Created by Pablo on 21/01/2018.
//  Copyright © 2018 Pablo Camiletti. All rights reserved.
//

import Foundation


internal struct UNUserSearchParameters
{
    /// The requested query parameter's name.
    static let queryName = "query"
    
    /// The requested page parameter's name.
    static let pageNumberName = "page"
    
    /// Amount of users per page parameter's name.
    static let usersPerPageName  = "per_page"
    
    
    /// Words that describe the users to be searched.
    let query         : String
    
    /// The requested page.
    let pageNumber    : Int
    
    /// The desired amount of users per page.
    let usersPerPage : Int
}


extension UNUserSearchParameters: ParametersURLRepresentable
{
    func asQueryItems() -> [URLQueryItem]
    {
        return [
            URLQueryItem(name: UNUserSearchParameters.queryName,
                         value: "\(self.query)"),
            URLQueryItem(name: UNUserSearchParameters.pageNumberName,
                         value: "\(self.pageNumber)"),
            URLQueryItem(name: UNUserSearchParameters.usersPerPageName,
                         value: "\(self.usersPerPage)")
        ]
    }
}
