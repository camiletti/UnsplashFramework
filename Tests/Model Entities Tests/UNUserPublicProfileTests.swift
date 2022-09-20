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

final class UNUserPublicProfileTests: XCTestCase {

    func testDecoding() throws {
        let jsonData = DemoData.dataFromJSONFile(named: "UserPublicProfileResponse")
        let decoder = JSONDecoder.unsplashDecoder
        let userPublicProfile = try decoder.decode(UNUserPublicProfile.self, from: jsonData)

        XCTAssertEqual(userPublicProfile.id, "bw613paXCbc")
        XCTAssertEqual(userPublicProfile.username, "camiletti")
        XCTAssertEqual(userPublicProfile.name, "Pablo Camiletti")
        XCTAssertEqual(userPublicProfile.firstName, "Pablo")
        XCTAssertEqual(userPublicProfile.lastName, "Camiletti")
        XCTAssertEqual(userPublicProfile.bio, "abc")
        XCTAssertEqual(userPublicProfile.location, "London, UK")
        XCTAssertEqual(userPublicProfile.totalCollections, 1)
        XCTAssertEqual(userPublicProfile.totalLikes, 14)
        XCTAssertEqual(userPublicProfile.totalPhotos, 1)
        XCTAssertFalse(userPublicProfile.isAvailableForHire)
        XCTAssertFalse(userPublicProfile.isFollowedByCurrentUser)
        XCTAssertNotNil(userPublicProfile.badge)
        XCTAssertEqual(userPublicProfile.followersCount, 35)
        XCTAssertEqual(userPublicProfile.followingCount, 20)
        XCTAssertEqual(userPublicProfile.downloadsCount, 25)
    }

    func testDecodingOptionalProperties() throws {
        let jsonData = DemoData.dataFromJSONFile(named: "UserPublicProfileWithNulls")
        let decoder = JSONDecoder.unsplashDecoder
        let userPublicProfile = try decoder.decode(UNUserPublicProfile.self, from: jsonData)

        XCTAssertEqual(userPublicProfile.id, "bw613paXCbc")
        XCTAssertEqual(userPublicProfile.username, "camiletti")
        XCTAssertEqual(userPublicProfile.name, "Pablo Camiletti")
        XCTAssertEqual(userPublicProfile.firstName, "Pablo")
        XCTAssertNil(userPublicProfile.lastName)
        XCTAssertNil(userPublicProfile.bio)
        XCTAssertNil(userPublicProfile.location)
        XCTAssertEqual(userPublicProfile.totalCollections, 1)
        XCTAssertEqual(userPublicProfile.totalLikes, 14)
        XCTAssertEqual(userPublicProfile.totalPhotos, 1)
        XCTAssertFalse(userPublicProfile.isAvailableForHire)
        XCTAssertFalse(userPublicProfile.isFollowedByCurrentUser)
        XCTAssertNil(userPublicProfile.badge)
        XCTAssertEqual(userPublicProfile.followersCount, 35)
        XCTAssertEqual(userPublicProfile.followingCount, 20)
        XCTAssertEqual(userPublicProfile.downloadsCount, 25)
    }
}
