//
//  UNAPITests.swift
//  Unsplash Framework iOS Tests
//
//  Copyright 2021 Pablo Camiletti
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

final class UNAPITests: XCTestCase {

    // MARK: - Declarations

    enum Constant {
        static let expectationTimeout = 5.0
    }

    // MARK: - Tests

    func testHeaders() {
        let credentials = UNCredentials(appID: "appID",
                                        secret: "secret")
        let urlSession = MockURLSession.mocking(data: nil,
                                                response: nil,
                                                error: nil,
                                                deadline: 0)
        let api = UNAPI(credentials: credentials, urlSession: urlSession)

        let expectedHeaders = [UNAPI.Header.acceptVersion.fieldName: UNAPI.Header.acceptVersion.fieldValue,
                               UNAPI.Header.authorization(appID: credentials.appID).fieldName: UNAPI.Header.authorization(appID: credentials.appID).fieldValue]

        // None of the parameters passed to the request matter for this test
        let task = api.request(.get,
                               endpoint: .photos,
                               parameters: nil,
                               completion: { (_: Result<[UNPhoto], UnsplashFramework.UNError>) in })

        XCTAssertEqual(task.originalRequest?.allHTTPHeaderFields, expectedHeaders)
    }

    func testNoDataReceivedErrorIfDataIsNil() {
        let credentials = UNCredentials(appID: "appID",
                                        secret: "secret")
        let urlSession = MockURLSession.mocking(data: nil,
                                                response: nil,
                                                error: nil,
                                                deadline: 0)
        let api = UNAPI(credentials: credentials, urlSession: urlSession)

        let expectation = expectation(description: "Error should be No Data Received")

        api.request(.get,
                    endpoint: .photos,
                    parameters: nil,
                    completion: { (result: Result<[UNPhoto], UnsplashFramework.UNError>) in
            guard case .failure(let error) = result,
                  error.reason == .noDataReceived else {
                      XCTFail("Result is instead \(result)")
                      return
                  }

            expectation.fulfill()
        })

        wait(for: [expectation], timeout: Constant.expectationTimeout)
    }

    func testResultIsFailureWhenAnErrorIsReceived() {
        let expectedError = UNError(reason: .serverNotReached)
        let credentials = UNCredentials(appID: "appID",
                                        secret: "secret")
        let urlSession = MockURLSession.mocking(data: DemoData.standardPhotoSearchResponse,
                                                response: nil,
                                                error: expectedError,
                                                deadline: 0)
        let api = UNAPI(credentials: credentials, urlSession: urlSession)

        let expectation = expectation(description: "Error should be No Data Received")

        api.request(.get,
                    endpoint: SearchType.photo.endpoint,
                    parameters: nil,
                    completion: { (result: Result<UNSearchResult<UNPhoto>, UnsplashFramework.UNError>) in
            guard case .failure(let error) = result,
                  error.reason == expectedError.reason else {
                      XCTFail("Result is instead \(result)")
                      return
                  }

            expectation.fulfill()
        })

        wait(for: [expectation], timeout: Constant.expectationTimeout)
    }
}
