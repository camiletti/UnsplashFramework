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
struct UNTopicPhotosParameters {

    // MARK: - Declarations

    enum QueryParameterName {
        /// Page number to retrieve.
        static let pageNumber = "page"
        /// Number of items per page.
        static let photosPerPage = "per_page"
        /// Filter by photo orientation.
        static let orientation = "orientation"
        /// How to sort the photos.
        static let order = "order_by"
    }

    // MARK: - Properties

    /// Page number to retrieve. (Optional; default: 1).
    let pageNumber: Int?

    /// Number of items per page. (Optional; default: 10).
    let photosPerPage: Int?

    /// Filter by photo orientation. (Optional)
    let orientation: UNPhotoOrientation?

    /// How to sort the photos. (Optional; Valid values: latest, oldest, popular; default: latest)
    let order: UNSort?
}

// MARK: - ParametersURLRepresentable
extension UNTopicPhotosParameters: ParametersURLRepresentable {

    func asQueryItems() -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()

        if let pageNumber {
            queryItems.append(URLQueryItem(name: QueryParameterName.pageNumber,
                                           value: "\(pageNumber)"))
        }

        if let photosPerPage {
            queryItems.append(URLQueryItem(name: QueryParameterName.photosPerPage,
                                           value: "\(photosPerPage)"))
        }

        if let orientation {
            queryItems.append(URLQueryItem(name: QueryParameterName.orientation,
                                           value: orientation.rawValue))
        }

        if let order {
            queryItems.append(URLQueryItem(name: QueryParameterName.order,
                                           value: order.rawValue))
        }

        return queryItems
    }
}
