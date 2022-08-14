//
//  UNCollectionSearchParameters.swift
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

/// The parameters' names and values that can be passed to Unsplash in a search.
struct UNCollectionSearchParameters {

    // MARK: - Declarations

    enum QueryParameterName {
        /// The requested query parameter's name.
        static let query = "query"
        /// The requested page parameter's name.
        static let pageNumber = "page"
        /// Amount of collections per page parameter's name.
        static let collectionsPerPage = "per_page"
    }

    /// Words that describe the collections to be searched.
    let query: String

    /// The requested page.
    let pageNumber: Int

    /// The desired amount of collections per page.
    let collectionsPerPage: Int
}

// MARK: - ParametersURLRepresentable
extension UNCollectionSearchParameters: ParametersURLRepresentable {

    func asQueryItems() -> [URLQueryItem] {
        [URLQueryItem(name: QueryParameterName.query,
                      value: query),
         URLQueryItem(name: QueryParameterName.pageNumber,
                      value: "\(pageNumber)"),
         URLQueryItem(name: QueryParameterName.collectionsPerPage,
                      value: "\(collectionsPerPage)")
        ]
    }
}