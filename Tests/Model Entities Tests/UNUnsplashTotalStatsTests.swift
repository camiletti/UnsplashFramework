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

final class UNUnsplashTotalStatsTests: XCTestCase {

    func testDecoding() throws {
        let jsonData = DemoData.standardTotalStatsResponse
        let decoder = JSONDecoder.unsplashDecoder
        let stats = try decoder.decode(UNUnsplashTotalStats.self, from: jsonData)

        XCTAssertEqual(stats.totalPhotos, 4421811)
        XCTAssertEqual(stats.photoDownloads, 4879058577)
        XCTAssertEqual(stats.photos, 4421811)
        XCTAssertEqual(stats.downloads, 4879058577)
        XCTAssertEqual(stats.views, 892975554097)
        XCTAssertEqual(stats.photographers, 311234)
        XCTAssertEqual(stats.pixels, 76717142270149)
        XCTAssertEqual(stats.downloadsPerSecond, 38)
        XCTAssertEqual(stats.viewsPerSecond, 6944)
        XCTAssertEqual(stats.developers, 317041)
        XCTAssertEqual(stats.applications, 19620)
        XCTAssertEqual(stats.requests, 156045753174)
    }
}
