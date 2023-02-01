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

struct AuthorizationAttemptParameters {

    // MARK: - Declarations

    enum QueryParameterName {
        static let accessKey = "client_id"
        static let redirectAuthenticationURI = "redirect_uri"
        static let responseType = "response_type"
        static let scope = "scope"
    }

    enum Constant {
        static let code = "code"
        static let scopeSeparator = "+"
    }

    // MARK: - Properties

    let credentials: UNCredentials

    let scope: Set<UserAuthorizationScope>
}

// MARK: - ParametersURLRepresentable
extension AuthorizationAttemptParameters: ParametersURLRepresentable {

    func asQueryItems() -> [URLQueryItem] {
        var queryItems = [URLQueryItem(name: QueryParameterName.accessKey, value: credentials.accessKey),
                          URLQueryItem(name: QueryParameterName.redirectAuthenticationURI, value: credentials.redirectAuthenticationURI),
                          URLQueryItem(name: QueryParameterName.responseType, value: Constant.code)]

        if !scope.isEmpty {
            let formattedScope = scope
                .map { $0.rawValue }
                .joined(separator: Constant.scopeSeparator)
            queryItems.append(URLQueryItem(name: QueryParameterName.scope, value: formattedScope))
        }

        return queryItems
    }
}
