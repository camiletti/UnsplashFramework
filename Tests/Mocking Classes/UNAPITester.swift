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
import XCTest
@testable import UnsplashFramework

final class UNAPITester: UNAPI {

    // MARK: - Properties

    let expectedMethod: UNAPI.HTTPMethod

    let expectedEndpoint: Endpoint

    let expectedParameters: ParametersURLRepresentable?

    // MARK: - Life Cycle

    init(credentials: UNCredentials,
         urlSession: URLSession,
         expectedMethod: UNAPI.HTTPMethod,
         expectedEndpoint: Endpoint,
         expectedParameters: ParametersURLRepresentable?) {
        self.expectedMethod = expectedMethod
        self.expectedEndpoint = expectedEndpoint
        self.expectedParameters = expectedParameters
        super.init(credentials: credentials, urlSession: urlSession)
    }

    private override init(credentials: UNCredentials, urlSession: URLSession = URLSession(configuration: .default)) {
        fatalError("This method shouldn't be used for testing")
    }

    // MARK: - Mock overrides

    override func request<T>(_ method: UNAPI.HTTPMethod,
                             endpoint: Endpoint,
                             parameters: ParametersURLRepresentable?) async throws -> T where T : Decodable {
        XCTAssertEqual(method, expectedMethod)
        XCTAssertEqual(endpoint.path, expectedEndpoint.path)
        XCTAssertEqual(parameters?.asQueryItems(), expectedParameters?.asQueryItems())
        return try await super.request(method, endpoint: endpoint, parameters: parameters)
    }
}
