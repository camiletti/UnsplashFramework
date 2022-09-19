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
        /// Search terms.
        static let query = "query"
        /// Page number to retrieve.
        static let pageNumber = "page"
        /// Number of items per page.
        static let collectionsPerPage = "per_page"
    }

    /// Search terms.
    let query: String

    /// Page number to retrieve. (Optional; default: 1)
    let pageNumber: Int?

    /// Number of items per page. (Optional; default: 10)
    let collectionsPerPage: Int?
}

// MARK: - ParametersURLRepresentable
extension UNCollectionSearchParameters: ParametersURLRepresentable {

    func asQueryItems() -> [URLQueryItem] {
        var queryItems = [URLQueryItem(name: QueryParameterName.query,
                                       value: "\(query)")]

        if let pageNumber {
            queryItems.append(URLQueryItem(name: QueryParameterName.pageNumber,
                                           value: "\(pageNumber)"))
        }

        if let collectionsPerPage {
            queryItems.append(URLQueryItem(name: QueryParameterName.collectionsPerPage,
                                           value: "\(collectionsPerPage)"))
        }

        return queryItems
    }
}
