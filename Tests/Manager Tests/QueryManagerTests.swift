//
//  QueryManagerTests.swift
//  Unsplash Framework Tests
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

final class QueryManagerTests: XCTestCase {

    // MARK: - Declarations

    private enum Constant {
        static let requestDeadline = 0.2
        static let expectationTimeout = 10.0
        static let credentials = UNCredentials(appID: "123", secret: "789")
    }

    // MARK: - Test listing photos

    func testListingPhotosReturnsExpectedResponse() {
        let dataExpectation = expectation(description: "The response should be parsed correctly")

        let endpoint = Endpoint.photos
        let expectedData = DemoData.standardPhotoListResponse
        let expectedPhotosCount = 10
        let parameters = UNPhotoListParameters(pageNumber: 10,
                                               photosPerPage: 10,
                                               sortOrder: .latest)
        let queryManager = QueryManager.mock(data: expectedData,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline)

        let completion: UNPhotoListClosure = { (result: Result<[UNPhoto], UnsplashFramework.UNError>) in
            print(result)
            if case .success(let photos) = result,
                photos.count == expectedPhotosCount {
                dataExpectation.fulfill()
            } else {
                XCTFail("\(result)")
            }
        }

        queryManager.listPhotos(with: parameters, completion: completion)

        wait(for: [dataExpectation], timeout: Constant.expectationTimeout)
    }

    // MARK: - Test searching photos

    func testSearchingReturnsExpectedResponse() {
        let dataExpectation = expectation(description: "The response should be parsed correctly")

        let searchType = SearchType.photo
        let expectedData = DemoData.standardPhotoSearchResponse
        let expectedTotalElements = 10000
        let expectedTotalPages = 1000
        let expectedElementsCount = 10
        let parameters = UNPhotoSearchParameters(query: "Forest",
                                                 pageNumber: 1,
                                                 photosPerPage: 10,
                                                 collections: nil,
                                                 orientation: nil)
        let queryManager = QueryManager.mock(data: expectedData,
                                             response: .mockingSuccess(endpoint: searchType.endpoint,
                                                                       parameters: parameters),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline)

        let completion: UNPhotoSearchClosure = { (result: Result<UNSearchResult<UNPhoto>, UnsplashFramework.UNError>) in
            if case .success(let searchResult) = result,
               searchResult.totalElements == expectedTotalElements,
               searchResult.totalPages == expectedTotalPages,
               searchResult.elements.count == expectedElementsCount {
                dataExpectation.fulfill()
            } else {
                XCTFail()
            }
        }

        queryManager.search(searchType, with: parameters, completion: completion)

        wait(for: [dataExpectation], timeout: Constant.expectationTimeout)
    }

    func testSearchingReturnsSuccessButWithUnexpectedDataResponse() {
        let dataExpectation = expectation(description: "The data received doesn't match the expected JSON format")

        let searchType = SearchType.photo
        let unexpectedData = "{}!@£$".data(using: .utf8)!
        let parameters = UNPhotoSearchParameters(query: "Forest",
                                                 pageNumber: 1,
                                                 photosPerPage: 10,
                                                 collections: nil,
                                                 orientation: nil)
        let queryManager = QueryManager.mock(data: unexpectedData,
                                             response: .mockingSuccess(endpoint: searchType.endpoint,
                                                                       parameters: parameters),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline)

        let completion: UNPhotoSearchClosure = { (result: Result<UNSearchResult<UNPhoto>, UnsplashFramework.UNError>) in
            if case .failure(let error) = result,
                error.reason == UNError.Reason.unableToParseDataCorrectly {
                dataExpectation.fulfill()
            } else {
                XCTFail()
            }
        }

        queryManager.search(searchType, with: parameters, completion: completion)

        wait(for: [dataExpectation], timeout: Constant.expectationTimeout)
    }
}
