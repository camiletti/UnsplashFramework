//
//  UNPhotoSearchParametersTests.swift
//  UNPhotoSearchParametersTests
//
//  Created by Pablo Camiletti on 25/07/2021.
//  Copyright © 2021 Pablo Camiletti. All rights reserved.
//

import Foundation
@testable import UnsplashFramework
import XCTest

final class UNPhotoSearchParametersTests: XCTestCase {

    func testAsQueryItemsWithoutOptionalProperties() {
        let expectedQuery = "Some search"
        let expectedPageNumber = 9
        let expectedPhotosPerPage = 6
        let expectedQueryItemsAmount = 3

        let collectionSearchParameters = UNPhotoSearchParameters(query: expectedQuery,
                                                                 pageNumber: expectedPageNumber,
                                                                 photosPerPage: expectedPhotosPerPage,
                                                                 collections: nil,
                                                                 orientation: nil)

        let queryItems = collectionSearchParameters.asQueryItems()

        XCTAssertEqual(queryItems.count, expectedQueryItemsAmount)

        let queryValue = queryItems
            .first(where: { $0.name == UNPhotoSearchParameters.QueryParameterName.queryName })?
            .value
        XCTAssertEqual(queryValue, expectedQuery)

        let pageNumberValue = queryItems
            .first(where: { $0.name == UNPhotoSearchParameters.QueryParameterName.pageNumberName })?
            .value
        XCTAssertEqual(pageNumberValue, "\(expectedPageNumber)")

        let collectionsPerPageValue = queryItems
            .first(where: { $0.name == UNPhotoSearchParameters.QueryParameterName.photosPerPageName })?
            .value
        XCTAssertEqual(collectionsPerPageValue, "\(expectedPhotosPerPage)")
    }

    func testAsQueryItemsWithOptionalProperties() {
        let expectedQuery = "Some search"
        let expectedPageNumber = 9
        let expectedPhotosPerPage = 6
        let expectedCollections = [DemoData.collectionA, DemoData.collectionB]
        let expectedCollectionIDs = "\(expectedCollections[0].id),\(expectedCollections[1].id)"
        let expectedOrientation = UNPhotoOrientation.landscape
        let expectedQueryItemsAmount = 5

        let collectionSearchParameters = UNPhotoSearchParameters(query: expectedQuery,
                                                                 pageNumber: expectedPageNumber,
                                                                 photosPerPage: expectedPhotosPerPage,
                                                                 collections: expectedCollections,
                                                                 orientation: expectedOrientation)

        let queryItems = collectionSearchParameters.asQueryItems()

        XCTAssertEqual(queryItems.count, expectedQueryItemsAmount)

        let queryValue = queryItems
            .first(where: { $0.name == UNPhotoSearchParameters.QueryParameterName.queryName })?
            .value
        XCTAssertEqual(queryValue, expectedQuery)

        let pageNumberValue = queryItems
            .first(where: { $0.name == UNPhotoSearchParameters.QueryParameterName.pageNumberName })?
            .value
        XCTAssertEqual(pageNumberValue, "\(expectedPageNumber)")

        let collectionsPerPageValue = queryItems
            .first(where: { $0.name == UNPhotoSearchParameters.QueryParameterName.photosPerPageName })?
            .value
        XCTAssertEqual(collectionsPerPageValue, "\(expectedPhotosPerPage)")

        let collectionsIDsValue = queryItems
            .first(where: { $0.name == UNPhotoSearchParameters.QueryParameterName.collectionIDsName })?
            .value
        XCTAssertEqual(collectionsIDsValue, expectedCollectionIDs)

        let orientationValue = queryItems
            .first(where: { $0.name == UNPhotoSearchParameters.QueryParameterName.orientationName })?
            .value
        XCTAssertEqual(orientationValue, expectedOrientation.rawValue)
    }
}
