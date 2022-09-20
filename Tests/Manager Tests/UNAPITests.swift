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

    // Accessing `urlSession.tasks` crashes in Xcode 13 beta 3
//    func testHeaders() async throws {
//        let credentials = UNCredentials(appID: "appID",
//                                        secret: "secret")
//        let urlSession = MockURLSession.mocking(data: nil,
//                                                response: nil,
//                                                error: nil,
//                                                deadline: Constant.dataTaskMockedDelay)
//        let api = UNAPI(credentials: credentials, urlSession: urlSession)
//
//        let expectedHeaders = [UNAPI.Header.acceptVersion.fieldName: UNAPI.Header.acceptVersion.fieldValue,
//                               UNAPI.Header.authorization(appID: credentials.appID).fieldName: UNAPI.Header.authorization(appID: credentials.appID).fieldValue]
//
//        // None of the parameters passed to the request matter for this test
//        let _: [UNPhoto] = try await api.request(.get,
//                                                 endpoint: .photos,
//                                                 parameters: nil)
//
//        let (dataTask, _, _) = await urlSession.tasks
//        XCTAssertEqual(dataTask.first?.originalRequest?.allHTTPHeaderFields, expectedHeaders)
//    }

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
            let _: UNSearchResult<UNPhoto> = try await api.request(.get,
                                                                   endpoint: SearchType.photo.endpoint,
                                                                   parameters: nil)
            XCTFail("Success is not what we expect here")
        } catch {
            // Error is the expected result
        }
    }
}
