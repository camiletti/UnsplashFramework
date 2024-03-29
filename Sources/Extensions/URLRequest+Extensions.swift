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

extension URLRequest {

    /// Creates and returns a URLRequest with the necessary headers for a public action.
    ///
    /// - Parameters:
    ///   - method: The HTTP method.
    ///   - endpoint: The endpoint for the desired query.
    ///   - parameters: The parameters for the request.
    ///   - credentials: Unsplash client credentials.
    /// - Returns: A new URLRequest containing the passed information.
    static func request(_ method: HTTPMethod,
                        forEndpoint endpoint: Endpoint,
                        at location: UnsplashHost.Location,
                        parameters: ParametersURLRepresentable?,
                        headers: [RequestHeader]) -> URLRequest {
        // Create new request
        let url = URLComponents(unsplashQuery: parameters?.asQueryItems(),
                                endpoint: endpoint,
                                at: location).url!
        var request = URLRequest(url: url)

        // Set method
        request.httpMethod = method.rawValue

        // Add headers
        headers.forEach { header in
            request.addValue(header.fieldValue, forHTTPHeaderField: header.fieldName)
        }

        return request
    }
}
