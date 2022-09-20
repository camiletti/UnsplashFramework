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

final class UNProfileImageLinksTests: XCTestCase {

    func testDecoding() throws {
        let jsonData = DemoData.dataFromJSONFile(named: "ProfileImageLinks")
        let decoder = JSONDecoder.unsplashDecoder
        let profileLinks = try decoder.decode(UNProfileImageLinks.self, from: jsonData)

        XCTAssertEqual(profileLinks.small, URL(string: "https://images.unsplash.com/profile-1659789472924-bc84b8c16170image?ixlib=rb-1.2.1&crop=faces&fit=crop&w=32&h=32")!)
        XCTAssertEqual(profileLinks.medium, URL(string: "https://images.unsplash.com/profile-1659789472924-bc84b8c16170image?ixlib=rb-1.2.1&crop=faces&fit=crop&w=64&h=64")!)
        XCTAssertEqual(profileLinks.large, URL(string: "https://images.unsplash.com/profile-1659789472924-bc84b8c16170image?ixlib=rb-1.2.1&crop=faces&fit=crop&w=128&h=128")!)
    }
}
