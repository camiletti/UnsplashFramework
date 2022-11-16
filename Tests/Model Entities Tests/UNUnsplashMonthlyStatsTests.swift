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

final class UNUnsplashMonthlyStatsTests: XCTestCase {

    func testDecoding() throws {
        let jsonData = DemoData.standardMonthlyStatsResponse
        let decoder = JSONDecoder.unsplashDecoder
        let stats = try decoder.decode(UNUnsplashMonthlyStats.self, from: jsonData)

        XCTAssertEqual(stats.downloads, 94520150)
        XCTAssertEqual(stats.views, 17507833235)
        XCTAssertEqual(stats.newPhotos, 109128)
        XCTAssertEqual(stats.newPhotographers, 2563)
        XCTAssertEqual(stats.newPixels, 2029576140858)
        XCTAssertEqual(stats.newDevelopers, 7237)
        XCTAssertEqual(stats.newApplications, 253)
        XCTAssertEqual(stats.newRequests, 1292409018)
    }
}
