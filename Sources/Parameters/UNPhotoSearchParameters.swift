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

/// The parameters' names and values that can be passed to Unsplash in a search.
struct UNPhotoSearchParameters {

    // MARK: - Declarations

    enum QueryParameterName {
        /// The requested query parameter's name.
        static let query = "query"
        /// The requested page parameter's name.
        static let pageNumber = "page"
        /// Amount of photos per page parameter's name.
        static let photosPerPage = "per_page"
        /// How to sort the photos.
        static let order = "order_by"
        /// Collections to narrow search parameter's name.
        static let collectionIDs = "collections"
        /// Limit results by content safety.
        static let safetyLevel = "content_filter"
        /// Filter results by color.
        static let colorScheme = "color"
        /// Filter by photo orientation.
        static let orientation = "orientation"
    }

    // MARK: - Life Cycle

    /// Search terms.
    let query: String

    /// Page number to retrieve. (Optional; default: 1)
    let pageNumber: Int?

    /// Number of items per page. (Optional; default: 10)
    let photosPerPage: Int?

    /// How to sort the photos. (Optional; default: relevant)
    let order: UNOrder?

    /// Collection ID(‘s) to narrow search. Optional.
    let collectionsIDs: [String]

    /// Limit results by content safety. (Optional; default: low).
    let safetyLevel: UNContentSafetyFilter?

    /// Filter results by color. Optional.
    let colorScheme: UNPhotoColorScheme?

    /// Filter by photo orientation. Optional.
    let orientation: UNPhotoOrientation?
}

// MARK: - ParametersURLRepresentable
extension UNPhotoSearchParameters: ParametersURLRepresentable {

    func asQueryItems() -> [URLQueryItem] {
        var queryItems = [URLQueryItem(name: QueryParameterName.query,
                                       value: "\(self.query)")]

        if let pageNumber {
            queryItems.append(URLQueryItem(name: QueryParameterName.pageNumber,
                                           value: "\(pageNumber)"))
        }

        if let photosPerPage {
            queryItems.append(URLQueryItem(name: QueryParameterName.photosPerPage,
                                           value: "\(photosPerPage)"))
        }

        if let order {
            queryItems.append(URLQueryItem(name: QueryParameterName.order,
                                           value: order.rawValue))
        }

        if !collectionsIDs.isEmpty {
            queryItems.append(URLQueryItem(name: QueryParameterName.collectionIDs,
                                           value: collectionsIDs.joined(separator: ",")))
        }

        if let safetyLevel {
            queryItems.append(URLQueryItem(name: QueryParameterName.safetyLevel,
                                           value: safetyLevel.rawValue))
        }

        if let colorScheme {
            queryItems.append(URLQueryItem(name: QueryParameterName.colorScheme,
                                           value: colorScheme.rawValue))
        }

        if let orientation {
            queryItems.append(URLQueryItem(name: QueryParameterName.orientation,
                                           value: orientation.rawValue))
        }

        return queryItems
    }
}
