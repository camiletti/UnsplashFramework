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

final class UNUpdateCollectionParametersTests: XCTestCase {

    func testAsQueryItemsWithoutOptionalProperties() {
        let expectedQueryItemsAmount = 0
        let parameters = UNUpdateCollectionParameters(title: nil, description: nil, isPrivate: nil)

        let queryItems = parameters.asQueryItems()

        XCTAssertEqual(queryItems.count, expectedQueryItemsAmount)
    }

    func testAsQueryItemsWithOptionalProperties() {
        let expectedTitle = "A Title"
        let expectedDescription = "A description"
        let expectedIsPrivate = true
        let expectedQueryItemsAmount = 3

        let parameters = UNUpdateCollectionParameters(title: expectedTitle,
                                                      description: expectedDescription,
                                                      isPrivate: expectedIsPrivate)

        let queryItems = parameters.asQueryItems()

        XCTAssertEqual(queryItems.count, expectedQueryItemsAmount)

        let titleValue = queryItems
            .first(where: { $0.name == UNNewCollectionParameters.QueryParameterName.title })?
            .value
        XCTAssertEqual(titleValue, expectedTitle)

        let descriptionValue = queryItems
            .first(where: { $0.name == UNNewCollectionParameters.QueryParameterName.description })?
            .value
        XCTAssertEqual(descriptionValue, expectedDescription)

        let isPrivateValue = queryItems
            .first(where: { $0.name == UNNewCollectionParameters.QueryParameterName.isPrivate })?
            .value
        XCTAssertEqual(isPrivateValue, "\(expectedIsPrivate)")
    }
}
