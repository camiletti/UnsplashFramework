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

struct AuthorizationTokenParameters {

    // MARK: - Declarations

    enum QueryParameterName {
        static let accessKey = "client_id"
        static let secret = "client_secret"
        static let redirectAuthenticationURI = "redirect_uri"
        static let code = "code"
        static let grantType = "grant_type"
        static let authorizationCode = "authorization_code"
    }

    // MARK: - Properties

    let credentials: UNCredentials

    let code: String
}

// MARK: - ParametersURLRepresentable
extension AuthorizationTokenParameters: ParametersURLRepresentable {

    func asQueryItems() -> [URLQueryItem] {
        [URLQueryItem(name: QueryParameterName.accessKey, value: credentials.accessKey),
         URLQueryItem(name: QueryParameterName.secret, value: credentials.secret),
         URLQueryItem(name: QueryParameterName.redirectAuthenticationURI, value: credentials.redirectAuthenticationURI),
         URLQueryItem(name: QueryParameterName.code, value: code),
         URLQueryItem(name: QueryParameterName.grantType, value: QueryParameterName.authorizationCode)]
    }
}
