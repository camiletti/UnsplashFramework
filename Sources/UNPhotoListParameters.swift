//
//  UNPhotoListParameters.swift
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

/// The parameters' names and values that can be passed to Unsplash in a query.
struct UNPhotoListParameters {

    // MARK: - Declarations

    enum QueryParameterName {
        /// The requested page parameter's name.
        static let pageNumberName = "page"
        /// Amount of photos per page parameter's name.
        static let photosPerPageName = "per_page"
        /// The sort order parameter's name.
        static let sortOrderName = "order_by"
    }

    // MARK: - Properties

    /// The requested page.
    let pageNumber: Int

    /// The desired amount of photos per page.
    let photosPerPage: Int

    /// The desired sort order of the query's result.
    let sortOrder: UNSort
}

// MARK: - ParametersURLRepresentable
extension UNPhotoListParameters: ParametersURLRepresentable {

    func asQueryItems() -> [URLQueryItem] {
        [URLQueryItem(name: QueryParameterName.pageNumberName,
                      value: "\(pageNumber)"),
         URLQueryItem(name: QueryParameterName.photosPerPageName,
                      value: "\(photosPerPage)"),
         URLQueryItem(name: QueryParameterName.sortOrderName,
                      value: "\(sortOrder.rawValue)")
        ]
    }
}
