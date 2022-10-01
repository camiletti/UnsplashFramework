//
//  UnsplashFramework
//
//  Copyright Pablo Camiletti
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
struct UNTopicListParameters {

    // MARK: - Declarations

    enum QueryParameterName {
        /// Limit to only matching topic ids or slugs. (Optional; Comma separated string)
        static let idsOrSlugs = "ids"
        /// Page number to retrieve.
        static let pageNumber = "page"
        /// Number of items per page.
        static let topicsPerPage = "per_page"
        /// How to sort the topics.
        static let sorting = "order_by"
    }

    // MARK: - Properties

    /// Limit to only matching topic ids or slugs. (Optional; Comma separated string)
    let idsOrSlugs: [String]?

    /// Page number to retrieve. (Optional; default: 1).
    let pageNumber: Int?

    /// Number of items per page. (Optional; default: 10).
    let topicsPerPage: Int?

    /// How to sort the topics. (Optional; default: position)
    let sorting: UNTopicSort?
}

// MARK: - ParametersURLRepresentable
extension UNTopicListParameters: ParametersURLRepresentable {

    func asQueryItems() -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()

        if let idsOrSlugs = idsOrSlugs {
            queryItems.append(URLQueryItem(name: QueryParameterName.idsOrSlugs,
                                           value: idsOrSlugs.joined(separator: ",")))
        }

        if let pageNumber = pageNumber {
            queryItems.append(URLQueryItem(name: QueryParameterName.pageNumber,
                                           value: "\(pageNumber)"))
        }

        if let topicsPerPage = topicsPerPage {
            queryItems.append(URLQueryItem(name: QueryParameterName.topicsPerPage,
                                           value: "\(topicsPerPage)"))
        }

        if let sorting = sorting {
            queryItems.append(URLQueryItem(name: QueryParameterName.sorting,
                                           value: "\(sorting.rawValue)"))
        }

        return queryItems
    }
}
