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

struct UNRandomPhotoParameters {

    // MARK: - Declarations

    enum QueryParameterName {
        /// Public collection ID(‘s) to filter selection.
        static let collectionIDs = "collections"
        /// Public topic ID(‘s) to filter selection.
        static let topicIDs = "topics"
        /// Limit selection to a single user.
        static let username = "username"
        /// Limit selection to photos matching a search term.
        static let searchQuery = "query"
        /// Filter by photo orientation.
        static let orientationFilter = "orientation"
        /// Limit results by content safety.
        static let contentFilter = "content_filter"
        /// The number of photos to return.
        static let amountOfRandomPhotos = "count"
    }

    // MARK: - Properties

    /// Public collection ID(‘s) to filter selection.
    let collectionIDs: [String]

    /// Public topic ID(‘s) to filter selection.
    let topicIDs: [String]

    /// The user’s username. Required.
    let username: String?

    /// Limit selection to photos matching a search term.
    let searchQuery: String?

    /// Filter by photo orientation.(Optional)
    let orientationFilter: UNPhotoOrientation?

    /// Limit results by content safety. Default: low. Valid values are low and high.
    let contentFilter: UNContentSafetyFilter?

    /// The number of photos to return. (Optional; Default: 1; max: 30)
    let amountOfRandomPhotos: Int
}

// MARK: - ParametersURLRepresentable
extension UNRandomPhotoParameters: ParametersURLRepresentable {

    func asQueryItems() -> [URLQueryItem] {
        /// When supplying a count parameter (and only then) the response will be an array of photos,
        /// even if the value of count is 1.
        /// To simplify the processing of the response, the count parameter is always supplied, so
        /// always an array is returned.
        var queryItems = [URLQueryItem(name: QueryParameterName.amountOfRandomPhotos,
                                       value: "\(amountOfRandomPhotos)")]

        let collectionIDs = collectionIDs.joined(separator: ",")
        if !collectionIDs.isEmpty {
            queryItems.append(URLQueryItem(name: QueryParameterName.collectionIDs,
                                           value: "\(collectionIDs)"))
        }

        let topicIDs = topicIDs.joined(separator: ",")
        if !topicIDs.isEmpty {
            queryItems.append(URLQueryItem(name: QueryParameterName.topicIDs,
                                           value: "\(topicIDs)"))
        }

        if let username = username {
            queryItems.append(URLQueryItem(name: QueryParameterName.username,
                                           value: "\(username)"))
        }

        // Collections or topics filtering can't be used with query parameters in the same request.
        if let searchQuery = searchQuery,
           self.collectionIDs.isEmpty,
           self.topicIDs.isEmpty {
            queryItems.append(URLQueryItem(name: QueryParameterName.searchQuery,
                                           value: "\(searchQuery)"))
        }

        if let orientationFilter = orientationFilter {
            queryItems.append(URLQueryItem(name: QueryParameterName.orientationFilter,
                                           value: "\(orientationFilter.rawValue)"))
        }

        if let contentFilter = contentFilter {
            queryItems.append(URLQueryItem(name: QueryParameterName.contentFilter,
                                           value: "\(contentFilter.rawValue)"))
        }

        /// When supplying a count parameter - and only then - the response will be an array of photos, even if the value of count is 1.

        return queryItems
    }
}
