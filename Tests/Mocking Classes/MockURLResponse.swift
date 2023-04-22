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
@testable import UnsplashFramework

extension URLResponse {

    static func mockingSuccess(endpoint: Endpoint,
                               at location: UnsplashHost.Location = .api,
                               parameters: ParametersURLRepresentable?,
                               headers: [String: String]?) -> HTTPURLResponse {
        let url = URLComponents(unsplashQuery: parameters?.asQueryItems(),
                                endpoint: endpoint,
                                at: .api).url!

        return HTTPURLResponse(url: url,
                               statusCode: ResponseStatusCode.success.rawValue,
                               httpVersion: nil,
                               headerFields: headers)!
    }

    static func mockingFailure(endpoint: Endpoint,
                               at location: UnsplashHost.Location = .api,
                               parameters: ParametersURLRepresentable?,
                               statusCode: ResponseStatusCode = .internalServerError,
                               headers: [String: String]? = nil) -> HTTPURLResponse {
        let url = URLComponents(unsplashQuery: parameters?.asQueryItems(),
                                endpoint: endpoint,
                                at: location).url!

        return HTTPURLResponse(url: url,
                               statusCode: statusCode.rawValue,
                               httpVersion: nil,
                               headerFields: headers)!
    }
}
