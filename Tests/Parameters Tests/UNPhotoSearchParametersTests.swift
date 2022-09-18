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

final class UNPhotoSearchParametersTests: XCTestCase {

    func testAsQueryItemsWithoutOptionalProperties() {
        let expectedQuery = "Some search"
        let expectedPageNumber = 9
        let expectedPhotosPerPage = 6
        let expectedOrder = UNOrder.latest
        let expectedCollectionsIDs = ["1", "2"]
        let expectedSafetyLevel = UNContentSafetyFilter.high
        let expectedColorScheme = UNPhotoColorScheme.blackAndWhite
        let expectedOrientation = UNPhotoOrientation.landscape
        let expectedQueryItemsAmount = 8

        let collectionSearchParameters = UNPhotoSearchParameters(query: expectedQuery,
                                                                 pageNumber: expectedPageNumber,
                                                                 photosPerPage: expectedPhotosPerPage,
                                                                 order: expectedOrder,
                                                                 collectionsIDs: expectedCollectionsIDs,
                                                                 safetyLevel: expectedSafetyLevel,
                                                                 colorScheme: expectedColorScheme,
                                                                 orientation: expectedOrientation)

        let queryItems = collectionSearchParameters.asQueryItems()

        XCTAssertEqual(queryItems.count, expectedQueryItemsAmount)

        let queryValue = queryItems
            .first(where: { $0.name == UNPhotoSearchParameters.QueryParameterName.query })?
            .value
        XCTAssertEqual(queryValue, expectedQuery)

        let pageNumberValue = queryItems
            .first(where: { $0.name == UNPhotoSearchParameters.QueryParameterName.pageNumber })?
            .value
        XCTAssertEqual(pageNumberValue, "\(expectedPageNumber)")

        let photosPerPageValue = queryItems
            .first(where: { $0.name == UNPhotoSearchParameters.QueryParameterName.photosPerPage })?
            .value
        XCTAssertEqual(photosPerPageValue, "\(expectedPhotosPerPage)")

        let orderValue = queryItems
            .first(where: { $0.name == UNPhotoSearchParameters.QueryParameterName.order })?
            .value
        XCTAssertEqual(orderValue, expectedOrder.rawValue)

        let collectionIDsValue = queryItems
            .first(where: { $0.name == UNPhotoSearchParameters.QueryParameterName.collectionIDs })?
            .value
        XCTAssertEqual(collectionIDsValue, expectedCollectionsIDs.joined(separator: ","))

        let safetyLevelValue = queryItems
            .first(where: { $0.name == UNPhotoSearchParameters.QueryParameterName.safetyLevel })?
            .value
        XCTAssertEqual(safetyLevelValue, expectedSafetyLevel.rawValue)

        let colorSchemeValue = queryItems
            .first(where: { $0.name == UNPhotoSearchParameters.QueryParameterName.colorScheme })?
            .value
        XCTAssertEqual(colorSchemeValue, expectedColorScheme.rawValue)

        let orientationValue = queryItems
            .first(where: { $0.name == UNPhotoSearchParameters.QueryParameterName.orientation })?
            .value
        XCTAssertEqual(orientationValue, expectedOrientation.rawValue)
    }

    func testAsQueryItemsWithOptionalProperties() {
        let expectedQuery = "Some search"
        let expectedQueryItemsAmount = 1

        let collectionSearchParameters = UNPhotoSearchParameters(query: expectedQuery,
                                                                 pageNumber: nil,
                                                                 photosPerPage: nil,
                                                                 order: nil,
                                                                 collectionsIDs: [],
                                                                 safetyLevel: nil,
                                                                 colorScheme: nil,
                                                                 orientation: nil)

        let queryItems = collectionSearchParameters.asQueryItems()

        XCTAssertEqual(queryItems.count, expectedQueryItemsAmount)  
    }
}
