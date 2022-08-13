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

/// The parameters' names and values that can be passed to fetch a user's public profile.
struct UNUserPhotosParameters {

    // MARK: - Declarations

    enum QueryParameterName {
        /// The user’s username. Required.
        static let username = "username"
        /// Page number to retrieve.
        static let pageNumber = "page"
        /// Number of items per page.
        static let photosPerPage = "per_page"
        /// How to sort the photos.
        static let sorting = "order_by"
        /// Show the stats for each user’s photo.
        static let includeStats = "stats"
        /// The frequency of the stats.
        static let statsInterval = "resolution"
        /// The amount of for each stat.
        static let statsAmount = "quantity"
        /// Filter by photo orientation.
        static let orientationFilter = "orientation"
    }

    // MARK: - Properties

    /// The user’s username. Required.
    let username: String

    /// Page number to retrieve. (Optional; default: 1)
    let pageNumber: Int?

    /// Number of items per page. (Optional; default: 10)
    let photosPerPage: Int?

    /// How to sort the photos. (Optional.; default: latest)
    let sorting: UNSort?

    /// Show the stats for each user’s photo. (Optional; default: false)
    let includeStats: Bool?

    /// The frequency of the stats. (Optional; default: “days”)
    let statsInterval: UNStatisticsInterval?

    /// The amount of for each stat. (Optional; default: 30)
    let statsAmount: Int?

    /// Filter by photo orientation. (Optional)
    let orientationFilter: UNPhotoOrientation?
}

// MARK: - ParametersURLRepresentable
extension UNUserPhotosParameters: ParametersURLRepresentable {

    func asQueryItems() -> [URLQueryItem] {
        var queryItems = [URLQueryItem(name: QueryParameterName.username,
                                       value: "\(username)")]

        if let pageNumber = pageNumber {
            queryItems.append(URLQueryItem(name: QueryParameterName.pageNumber,
                                           value: "\(pageNumber)"))
        }

        if let photosPerPage = photosPerPage {
            queryItems.append(URLQueryItem(name: QueryParameterName.photosPerPage,
                                           value: "\(photosPerPage)"))
        }

        if let sorting = sorting {
            queryItems.append(URLQueryItem(name: QueryParameterName.sorting,
                                           value: "\(sorting.rawValue)"))
        }

        if let includeStats = includeStats {
            queryItems.append(URLQueryItem(name: QueryParameterName.includeStats,
                                           value: "\(includeStats)"))
        }

        if let statsInterval = statsInterval {
            queryItems.append(URLQueryItem(name: QueryParameterName.statsInterval,
                                           value: "\(statsInterval.rawValue)"))
        }

        if let statsAmount = statsAmount {
            queryItems.append(URLQueryItem(name: QueryParameterName.statsAmount,
                                           value: "\(statsAmount)"))
        }

        if let orientationFilter = orientationFilter {
            queryItems.append(URLQueryItem(name: QueryParameterName.orientationFilter,
                                           value: "\(orientationFilter.rawValue)"))
        }

        return queryItems
    }
}
