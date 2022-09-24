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
struct UNNewCollectionParameters {

    // MARK: - Declarations

    enum QueryParameterName {
        /// The title of the collection.
        static let title = "title"
        /// The collection’s description.
        static let description = "description"
        /// Whether to make this collection private.
        static let isPrivate = "private"
    }

    // MARK: - Properties

    /// The title of the collection. (Required)
    let title: String

    /// The collection’s description. (Optional)
    let description: String?

    /// Whether to make this collection private. (Optional; default false).
    let isPrivate: Bool?
}

// MARK: - ParametersURLRepresentable
extension UNNewCollectionParameters: ParametersURLRepresentable {

    func asQueryItems() -> [URLQueryItem] {
        var queryItems = [URLQueryItem(name: QueryParameterName.title,
                                       value: title)]

        if let description {
            queryItems.append(URLQueryItem(name: QueryParameterName.description,
                                           value: description))
        }

        if let isPrivate {
            queryItems.append(URLQueryItem(name: QueryParameterName.isPrivate,
                                           value: "\(isPrivate)"))
        }

        return queryItems
    }
}
