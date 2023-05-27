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

/// Available response headers as described at https://unsplash.com/documentation
enum ResponseHeader {
    case requestLimit(Int)
    case requestsRemaining(Int)
    case totalNumberOfElements(Int)
    case elementsPerPage(Int)

    // MARK: - Declarations

    enum Key: String, CaseIterable {
        case requestLimit = "X-Ratelimit-Limit"
        case requestsRemaining = "X-Ratelimit-Remaining"
        case totalNumberOfElements = "X-Total"
        case elementsPerPage = "X-Per-Page"
    }

    // MARK: - Actions

    private static func headerField(for field: Key, value: String) -> ResponseHeader? {
        switch field {
        case .requestLimit:
            if let amount = Int(value) {
                return .requestLimit(amount)
            }

        case .requestsRemaining:
            if let amount = Int(value) {
                return .requestsRemaining(amount)
            }

        case .totalNumberOfElements:
            if let amount = Int(value) {
                return .totalNumberOfElements(amount)
            }

        case .elementsPerPage:
            if let amount = Int(value) {
                return .elementsPerPage(amount)
            }
        }

        return nil
    }

    static func headers(from response: HTTPURLResponse) -> [ResponseHeader] {
        Key.allCases.compactMap {
            guard let value = response.value(forHTTPHeaderField: $0.rawValue) else {
                return nil
            }

            return headerField(for: $0, value: value)
        }
    }
}
