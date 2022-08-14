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

import Foundation
@testable import UnsplashFramework
import XCTest

final class QueryManagerTests: XCTestCase {

    // MARK: - Declarations

    private enum Constant {
        static let requestDeadline = 0.2
        static let credentials = UNCredentials(accessKey: "123", secret: "789")
    }

    // MARK: - Test listing photos

    func testListingPhotosReturnsExpectedResponse() async throws {
        let endpoint = Endpoint.editorialPhotosList
        let expectedData = DemoData.standardPhotoListResponse
        let expectedPhotosCount = 10
        let parameters = UNPhotoListParameters(pageNumber: 10,
                                               photosPerPage: 10,
                                               sorting: .latest)
        let queryManager = QueryManager.mock(data: expectedData,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)

        let photos = try await queryManager.editorialPhotosList(with: parameters)

        XCTAssertEqual(photos.count, expectedPhotosCount)
    }

    // MARK: - Test searching photos

    func testSearchingReturnsExpectedResponse() async throws {
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
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: searchType.endpoint,
                                             expectedParameters: parameters)

        let photosSearchResult: UNSearchResult<UNPhoto> = try await queryManager.search(searchType, with: parameters)

        XCTAssertEqual(photosSearchResult.totalElements, expectedTotalElements)
        XCTAssertEqual(photosSearchResult.totalPages, expectedTotalPages)
        XCTAssertEqual(photosSearchResult.elements.count, expectedElementsCount)
    }

    func testSearchingReturnsSuccessButWithUnexpectedDataResponse() async throws {
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
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: searchType.endpoint,
                                             expectedParameters: parameters)

        do {
            let _: UNSearchResult<UNPhoto> = try await queryManager.search(searchType, with: parameters)
            XCTFail("Success is not expected here")
        } catch _ as DecodingError {
            // Expected error
        } catch {
            XCTFail("\(error) is not the expected error")
        }
    }
}
