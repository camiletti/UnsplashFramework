//
//  Unsplash Framework Tests
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

final class UNPhotoStatisticsTests: XCTestCase {

    func testDecoding() throws {
        let jsonData = DemoData.photoStatisticsResponse
        let decoder = JSONDecoder.unsplashDecoder
        let photoStats = try decoder.decode(UNPhotoStatistics.self, from: jsonData)

        XCTAssertEqual(photoStats.downloads.total, 33809)
        XCTAssertEqual(photoStats.downloads.history.amountOfChanges, 511)
        XCTAssertEqual(photoStats.downloads.history.interval, .days)
        XCTAssertEqual(photoStats.downloads.history.changes.count, 30)

        XCTAssertEqual(photoStats.views.total, 3226410)
        XCTAssertEqual(photoStats.views.history.amountOfChanges, 45266)
        XCTAssertEqual(photoStats.views.history.interval, .days)
        XCTAssertEqual(photoStats.views.history.changes.count, 30)

        XCTAssertEqual(photoStats.likes.total, 0)
        XCTAssertEqual(photoStats.likes.history.amountOfChanges, 0)
        XCTAssertEqual(photoStats.likes.history.interval, .days)
        XCTAssertEqual(photoStats.likes.history.changes.count, 30)
    }
}
