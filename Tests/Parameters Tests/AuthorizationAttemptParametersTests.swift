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

final class AuthorizationAttemptParametersTests: XCTestCase {

    func testAsQueryItems() {
        let rawCompletionURI = "UnsplashFramework://open/auth/completed"
        let expectedScope: Set<UserAuthorizationScope> = [.readUser, .readPhotos, .readCollections]
        let expectedCompletionURI = rawCompletionURI.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        let expectedQueryItemsAmount = 4
        let parameters = AuthorizationAttemptParameters(credentials: UNCredentials(accessKey: "123", secret: "abc"),
                                                        completionURI: rawCompletionURI,
                                                        scope: expectedScope)

        let queryItems = parameters.asQueryItems()

        XCTAssertEqual(queryItems.count, expectedQueryItemsAmount)

        let accessKey = queryItems
            .first(where: { $0.name == AuthorizationAttemptParameters.QueryParameterName.accessKey })?
            .value
        XCTAssertEqual(accessKey, "\(parameters.credentials.accessKey)")

        let completionURI = queryItems
            .first(where: { $0.name == AuthorizationAttemptParameters.QueryParameterName.completionURI })?
            .value
        XCTAssertEqual(completionURI, expectedCompletionURI)

        let responseType = queryItems
            .first(where: { $0.name == AuthorizationAttemptParameters.QueryParameterName.responseType })?
            .value
        XCTAssertEqual(responseType, "\(AuthorizationAttemptParameters.Constant.code)")

        let scope = queryItems
            .first(where: { $0.name == AuthorizationAttemptParameters.QueryParameterName.scope })?
            .value
        // Because sets have no order, we'll examine each component
        let receivedScope = scope?.components(separatedBy: AuthorizationAttemptParameters.Constant.scopeSeparator)
        XCTAssertEqual(receivedScope?.count, expectedScope.count)
        expectedScope.forEach { XCTAssertTrue(receivedScope!.contains($0.rawValue)) }
    }
}
