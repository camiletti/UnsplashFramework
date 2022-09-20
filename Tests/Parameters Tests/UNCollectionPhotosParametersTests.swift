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

final class UNCollectionPhotosParametersTests: XCTestCase {

    func testAsQueryItemsWithoutOptionalProperties() {
        let parameters = UNCollectionPhotosParameters(pageNumber: nil, photosPerPage: nil, orientation: nil)

        let queryItems = parameters.asQueryItems()

        XCTAssertTrue(queryItems.isEmpty)
    }

    func testAsQueryItemsWithOptionalProperties() {
        let expectedPageNumber = 9
        let expectedPhotosPerPage = 6
        let expectedOrientation = UNPhotoOrientation.landscape
        let expectedQueryItemsAmount = 3

        let parameters = UNCollectionPhotosParameters(pageNumber: expectedPageNumber,
                                                      photosPerPage: expectedPhotosPerPage,
                                                      orientation: expectedOrientation)

        let queryItems = parameters.asQueryItems()

        XCTAssertEqual(queryItems.count, expectedQueryItemsAmount)

        let pageNumberValue = queryItems
            .first(where: { $0.name == UNCollectionPhotosParameters.QueryParameterName.pageNumber })?
            .value
        XCTAssertEqual(pageNumberValue, "\(expectedPageNumber)")

        let photosPerPageValue = queryItems
            .first(where: { $0.name == UNCollectionPhotosParameters.QueryParameterName.photosPerPage })?
            .value
        XCTAssertEqual(photosPerPageValue, "\(expectedPhotosPerPage)")

        let orientationValue = queryItems
            .first(where: { $0.name == UNCollectionPhotosParameters.QueryParameterName.orientation })?
            .value
        XCTAssertEqual(orientationValue, "\(expectedOrientation.rawValue)")
    }
}
