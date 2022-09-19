//
//  UNUserSearchParametersTests.swift
//  UNUserSearchParametersTests
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

final class UNUserSearchParametersTests: XCTestCase {

    func testAsQueryItemsWithoutOptionalProperties() {
        let expectedQuery = "Some search"
        let expectedPageNumber = 9
        let expectedUsersPerPage = 6
        let expectedQueryItemsAmount = 3

        let collectionSearchParameters = UNUserSearchParameters(query: expectedQuery,
                                                                pageNumber: expectedPageNumber,
                                                                usersPerPage: expectedUsersPerPage)

        let queryItems = collectionSearchParameters.asQueryItems()

        XCTAssertEqual(queryItems.count, expectedQueryItemsAmount)

        let queryValue = queryItems
            .first(where: { $0.name == UNUserSearchParameters.QueryParameterName.query })?
            .value
        XCTAssertEqual(queryValue, expectedQuery)

        let pageNumberValue = queryItems
            .first(where: { $0.name == UNUserSearchParameters.QueryParameterName.pageNumber })?
            .value
        XCTAssertEqual(pageNumberValue, "\(expectedPageNumber)")

        let collectionsPerPageValue = queryItems
            .first(where: { $0.name == UNUserSearchParameters.QueryParameterName.usersPerPage })?
            .value
        XCTAssertEqual(collectionsPerPageValue, "\(expectedUsersPerPage)")
    }

    func testAsQueryItemsWithOptionalProperties() {
        let expectedQuery = "Some search"
        let expectedQueryItemsAmount = 1

        let collectionSearchParameters = UNUserSearchParameters(query: expectedQuery,
                                                                pageNumber: nil,
                                                                usersPerPage: nil)

        let queryItems = collectionSearchParameters.asQueryItems()

        XCTAssertEqual(queryItems.count, expectedQueryItemsAmount)

        let queryValue = queryItems
            .first(where: { $0.name == UNUserSearchParameters.QueryParameterName.query })?
            .value
        XCTAssertEqual(queryValue, expectedQuery)
    }
}
