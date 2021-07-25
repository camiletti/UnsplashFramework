//
//  UNClientTests.swift
//  UnsplashFrameworkTests
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

final class UNClientTests: XCTestCase {

    // MARK: - Declarations

    private enum Constant {
        static let requestDeadline = 0.2
        static let expectationTimeout = 10.0
        static let credentials = UNCredentials(appID: "123", secret: "789")
    }

    // MARK: - Tests

    func testListingPhotos() {
        let resultExpectation = expectation(description: "An array of photos should be returned")
        // The only important parameter for this test is the data that will be returned
        let queryManager = QueryManager.mock(data: DemoData.standardPhotoListResponse,
                                             response: .mockingSuccess(endpoint: .photos,
                                                                       parameters: nil),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline)

        let client = UNClient(queryManager: queryManager)
        // None of the parameters are relevant for this test
        client.listPhotos(page: 1,
                          photosPerPage: 1,
                          sortingBy: .popular,
                          completion: { (result: Result<[UNPhoto], UnsplashFramework.UNError>) in
            guard case .success(let photos) = result,
                  !photos.isEmpty else {
                      XCTFail()
                      return
                  }
            resultExpectation.fulfill()
        })

        wait(for: [resultExpectation], timeout: Constant.expectationTimeout)
    }

    func testSearchPhotos() {
        let resultExpectation = expectation(description: "A search result with photos should be returned")
        // The only important parameter for this test is the data that will be returned
        let queryManager = QueryManager.mock(data: DemoData.standardPhotoSearchResponse,
                                             response: .mockingSuccess(endpoint: SearchType.photo.endpoint,
                                                                       parameters: nil),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline)

        let client = UNClient(queryManager: queryManager)
        // None of the parameters are relevant for this test
        client.searchPhotos(query: "",
                            page: 1,
                            photosPerPage: 10,
                            collections: [],
                            orientation: nil,
                            completion: { (result: Result<UNSearchResult<UNPhoto>, UnsplashFramework.UNError>) in
            guard case .success(let searchResult) = result,
                  !searchResult.elements.isEmpty else {
                      XCTFail()
                      return
                  }
            resultExpectation.fulfill()
        })

        wait(for: [resultExpectation], timeout: Constant.expectationTimeout)
    }

    func testSearchCollection() {
        let resultExpectation = expectation(description: "A search result with collections should be returned")
        // The only important parameter for this test is the data that will be returned
        let queryManager = QueryManager.mock(data: DemoData.standardCollectionSearchResponse,
                                             response: .mockingSuccess(endpoint: SearchType.collection.endpoint,
                                                                       parameters: nil),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline)

        let client = UNClient(queryManager: queryManager)
        // None of the parameters are relevant for this test
        client.searchCollections(query: "",
                                 page: 1,
                                 collectionsPerPage: 10,
                                 completion: { (result: Result<UNSearchResult<UNCollection>, UnsplashFramework.UNError>) in
            guard case .success(let searchResult) = result,
                  !searchResult.elements.isEmpty else {
                      XCTFail()
                      return
                  }
            resultExpectation.fulfill()
        })

        wait(for: [resultExpectation], timeout: Constant.expectationTimeout)
    }

    func testSearchUsers() {
        let resultExpectation = expectation(description: "A search result with users should be returned")
        // The only important parameter for this test is the data that will be returned
        let queryManager = QueryManager.mock(data: DemoData.standardUserSearchResponse,
                                             response: .mockingSuccess(endpoint: SearchType.user.endpoint,
                                                                       parameters: nil),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline)

        let client = UNClient(queryManager: queryManager)
        // None of the parameters are relevant for this test
        client.searchUsers(query: "",
                           page: 1,
                           usersPerPage: 10,
                           completion: { (result: Result<UNSearchResult<UNUser>, UnsplashFramework.UNError>) in
            guard case .success(let searchResult) = result,
                  !searchResult.elements.isEmpty else {
                      XCTFail()
                      return
                  }
            resultExpectation.fulfill()
        })

        wait(for: [resultExpectation], timeout: Constant.expectationTimeout)
    }
}
