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

final class UNSocialProfilesTests: XCTestCase {

    func testDecoding() throws {
        let jsonData = DemoData.dataFromJSONFile(named: "Social")
        let decoder = JSONDecoder.unsplashDecoder
        let socialProfiles = try decoder.decode(UNSocialProfiles.self, from: jsonData)

        XCTAssertEqual(socialProfiles.instagramUsername, "instagram")
        XCTAssertEqual(socialProfiles.twitterUsername, "camiletti_p")
        XCTAssertEqual(socialProfiles.portfolioURL, URL(string: "https://www.behance.net/camiletti")!)
        XCTAssertEqual(socialProfiles.paypalEmailOrUsername, "paypal")
    }

    func testDecodingOptionalProperties() throws {
        let jsonData = DemoData.dataFromJSONFile(named: "SocialWithNulls")
        let decoder = JSONDecoder.unsplashDecoder
        let socialProfiles = try decoder.decode(UNSocialProfiles.self, from: jsonData)

        XCTAssertNil(socialProfiles.instagramUsername)
        XCTAssertNil(socialProfiles.twitterUsername)
        XCTAssertNil(socialProfiles.portfolioURL)
        XCTAssertNil(socialProfiles.paypalEmailOrUsername)
    }
}
