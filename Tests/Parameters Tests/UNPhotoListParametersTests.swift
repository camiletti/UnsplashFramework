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

@testable import UnsplashFramework
import XCTest

final class UNPhotoListParametersTests: XCTestCase {

    func testAsQueryItemsWithoutOptionalProperties() {
        let parameters = UNPhotoListParameters(pageNumber: nil, photosPerPage: nil, sorting: nil)

        let queryItems = parameters.asQueryItems()

        XCTAssertTrue(queryItems.isEmpty)
    }

    func testAsQueryItemsWithOptionalProperties() {
        let expectedPageNumber = 9
        let expectedPhotosPerPage = 6
        let expectedSorting = UNSort.downloads
        let expectedQueryItemsAmount = 3

        let parameters = UNPhotoListParameters(pageNumber: expectedPageNumber,
                                               photosPerPage: expectedPhotosPerPage,
                                               sorting: expectedSorting)

        let queryItems = parameters.asQueryItems()

        XCTAssertEqual(queryItems.count, expectedQueryItemsAmount)

        let pageNumberValue = queryItems
            .first(where: { $0.name == UNPhotoListParameters.QueryParameterName.pageNumber })?
            .value
        XCTAssertEqual(pageNumberValue, "\(expectedPageNumber)")

        let photosPerPageValue = queryItems
            .first(where: { $0.name == UNPhotoListParameters.QueryParameterName.photosPerPage })?
            .value
        XCTAssertEqual(photosPerPageValue, "\(expectedPhotosPerPage)")

        let sortingValue = queryItems
            .first(where: { $0.name == UNPhotoListParameters.QueryParameterName.sorting })?
            .value
        XCTAssertEqual(sortingValue, "\(expectedSorting.rawValue)")
    }
}
