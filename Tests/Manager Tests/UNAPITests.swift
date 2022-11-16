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
import XCTest

final class UNAPITests: XCTestCase {

    // MARK: - Declarations

    enum Constant {
        static let dataTaskMockedDelay = 1.0
    }

    // MARK: - Tests

    func testHeaders() async throws {
        let credentials = UNCredentials(accessKey: "appID", secret: "secret")
        let headerCheckExpectation = expectation(description: "Header check should have been executed")
        let expectedHeaders: [String: Any] = [RequestHeader.acceptVersion.fieldName: RequestHeader.acceptVersion.fieldValue,
                                              RequestHeader.authorization(accessKey: credentials.accessKey).fieldName: RequestHeader.authorization(accessKey: credentials.accessKey).fieldValue]

        let requestHeaderCheck: ([AnyHashable: Any]) -> Void = { (headers: [AnyHashable: Any]) in
            guard let headers = headers as? [String: Any] else {
                XCTFail("Incorrect header type")
                return
            }

            XCTAssertEqual(headers.count, expectedHeaders.count)

            for header in headers {
                // To simplify the test, because at the moment all values are string we'll force cast.
                // This will need to be reconsider if in the future other types are passed as header values.
                XCTAssertEqual(header.value as! String, expectedHeaders[header.key] as! String)
            }

            headerCheckExpectation.fulfill()
        }

        let urlSession = URLSession.mocking(data: DemoData.standardPhotoSearchResponse,
                                            response: .mockingSuccess(endpoint: SearchType.photo.endpoint,
                                                                      parameters: nil,
                                                                      headers: nil),
                                            error: nil,
                                            deadline: Constant.dataTaskMockedDelay,
                                            requestHeaderCheck: requestHeaderCheck)
        let api = UNAPI(credentials: credentials, urlSession: urlSession)

        let _: (UNSearchResult<UNPhoto>, _) = try await api.request(.get,
                                                                    endpoint: SearchType.photo.endpoint,
                                                                    parameters: nil)

        wait(for: [headerCheckExpectation], timeout: 0.1)
    }

    func testResultIsFailureWhenAnErrorIsReceived() async throws {
        let expectedError = UNError(reason: .serverNotReached)
        let credentials = UNCredentials(accessKey: "accessKey",
                                        secret: "secret")
        let urlSession = URLSession.mocking(data: DemoData.standardPhotoSearchResponse,
                                            response: nil,
                                            error: expectedError,
                                            deadline: 0)
        let api = UNAPI(credentials: credentials, urlSession: urlSession)

        do {
            let _: (UNSearchResult<UNPhoto>, _) = try await api.request(.get,
                                                                        endpoint: SearchType.photo.endpoint,
                                                                        parameters: nil)
            XCTFail("Success is not what we expect here")
        } catch {
            // Error is the expected result
        }
    }
}
