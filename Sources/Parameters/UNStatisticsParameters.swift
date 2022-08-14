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

struct UNStatisticsParameters {

    // MARK: - Declarations

    enum QueryParameterName {
        /// The frequency of the stats.
        static let interval = "resolution"
        /// The amount of for each stat.
        static let quantity = "quantity"
    }

    // MARK: - Properties

    /// The frequency of the stats. (Optional; default: “days”)
    let interval: UNStatisticsInterval?

    /// The amount of for each stat. (Optional; Between 1 and 30; default: 30)
    let quantity: Int?
}

// MARK: - ParametersURLRepresentable
extension UNStatisticsParameters: ParametersURLRepresentable {

    func asQueryItems() -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()

        if let interval = interval {
            queryItems.append(URLQueryItem(name: QueryParameterName.interval,
                                           value: "\(interval.rawValue)"))
        }

        if let quantity = quantity {
            queryItems.append(URLQueryItem(name: QueryParameterName.quantity,
                                           value: "\(quantity)"))
        }

        return queryItems
    }
}
