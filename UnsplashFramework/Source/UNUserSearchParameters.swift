//
//  UNUserSearchParameters.swift
//  UnsplashFramework
//
//  Created by Pablo on 21/01/2018.
//  Copyright © 2018 Pablo Camiletti. All rights reserved.
//

struct UNUserSearchParameters {

    // MARK: - Declarations

    private enum QueryParameterName {
        /// The requested query parameter's name.
        static let queryName = "query"

        /// The requested page parameter's name.
        static let pageNumberName = "page"

        /// Amount of users per page parameter's name.
        static let usersPerPageName = "per_page"
    }

    // MARK: - Properties

    /// Words that describe the users to be searched.
    let query: String

    /// The requested page.
    let pageNumber: Int

    /// The desired amount of users per page.
    let usersPerPage: Int
}

// MARK: - ParametersURLRepresentable
extension UNUserSearchParameters: ParametersURLRepresentable {

    func asQueryItems() -> [URLQueryItem] {
        [URLQueryItem(name: QueryParameterName.queryName,
                      value: "\(query)"),
         URLQueryItem(name: QueryParameterName.pageNumberName,
                      value: "\(pageNumber)"),
         URLQueryItem(name: QueryParameterName.usersPerPageName,
                      value: "\(usersPerPage)")
        ]
    }
}
