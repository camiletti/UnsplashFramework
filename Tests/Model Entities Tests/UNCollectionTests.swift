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

final class UNCollectionTests: XCTestCase {

    func testDecoding() throws {
        let jsonData = DemoData.standardCollectionAResponse
        let decoder = JSONDecoder.unsplashDecoder
        let collection = try decoder.decode(UNCollection.self, from: jsonData)

        XCTAssertEqual(collection.id, "6820058")
        XCTAssertEqual(collection.title, "Jungle")
        XCTAssertEqual(collection.description, "Images about jungles")
        XCTAssertNotNil(collection.publishedDate)
        XCTAssertNotNil(collection.lastCollectedDate)
        XCTAssertNotNil(collection.updatedDate)
        XCTAssertTrue(collection.isCurated)
        XCTAssertTrue(collection.wasFeatured)
        XCTAssertTrue(collection.isPrivate)
        XCTAssertEqual(collection.totalAmountOfPhotos, 13)
        XCTAssertEqual(collection.shareKey, "09491bebece24560a48da4773e7fa2e2")
        XCTAssertEqual(collection.tags.count, 6)
        XCTAssertNotNil(collection.user)
        XCTAssertNotNil(collection.coverPhoto)
        XCTAssertEqual(collection.previewPhotos.count, 4)
    }
}
