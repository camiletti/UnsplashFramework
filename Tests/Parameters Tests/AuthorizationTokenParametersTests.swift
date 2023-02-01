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

@testable import UnsplashFramework
import XCTest

final class AuthorizationTokenParametersTests: XCTestCase {

    func testAsQueryItems() {
        let expectedQueryItemsAmount = 5
        let parameters = AuthorizationTokenParameters(credentials: UNCredentials(accessKey: "123",
                                                                                 secret: "abc",
                                                                                 redirectAuthenticationURI: "unsplashframework://open/auth"),
                                                        code: "qwerty")

        let queryItems = parameters.asQueryItems()

        XCTAssertEqual(queryItems.count, expectedQueryItemsAmount)

        let accessKey = queryItems
            .first(where: { $0.name == AuthorizationTokenParameters.QueryParameterName.accessKey })?
            .value
        XCTAssertEqual(accessKey, parameters.credentials.accessKey)

        let secret = queryItems
            .first(where: { $0.name == AuthorizationTokenParameters.QueryParameterName.secret })?
            .value
        XCTAssertEqual(secret, parameters.credentials.secret)

        let redirectAuthenticationURI = queryItems
            .first(where: { $0.name == AuthorizationTokenParameters.QueryParameterName.redirectAuthenticationURI })?
            .value
        XCTAssertEqual(redirectAuthenticationURI, parameters.credentials.redirectAuthenticationURI)

        let code = queryItems
            .first(where: { $0.name == AuthorizationTokenParameters.QueryParameterName.code })?
            .value
        XCTAssertEqual(code, "\(parameters.code)")

        let grantType = queryItems
            .first(where: { $0.name == AuthorizationTokenParameters.QueryParameterName.grantType })?
            .value
        XCTAssertEqual(grantType, AuthorizationTokenParameters.QueryParameterName.authorizationCode)
    }
}
