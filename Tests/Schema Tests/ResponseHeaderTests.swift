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

final class ResponseHeaderTests: XCTestCase {

    func testHeaderParsing() {
        var rawHeaders: [String: String] = [ResponseHeader.Key.requestLimit.rawValue: "50",
                                            ResponseHeader.Key.requestsRemaining.rawValue: "25",
                                            ResponseHeader.Key.totalNumberOfElements.rawValue: "101",
                                            ResponseHeader.Key.elementsPerPage.rawValue: "10"]

        let response = URLResponse.mockingSuccess(endpoint: .editorialPhotosList,
                                                  parameters: nil,
                                                  headers: rawHeaders)

        let headers = ResponseHeader.headers(from: response)
        XCTAssertEqual(headers.count, rawHeaders.count)

        for header in headers {
            switch header {
            case .requestLimit(let amount):
                let expectedLimit = Int(rawHeaders[ResponseHeader.Key.requestLimit.rawValue]!)!
                XCTAssertEqual(amount, expectedLimit)
                rawHeaders.removeValue(forKey: ResponseHeader.Key.requestLimit.rawValue)

            case .requestsRemaining(let amount):
                let expectedRemaining = Int(rawHeaders[ResponseHeader.Key.requestsRemaining.rawValue]!)!
                XCTAssertEqual(amount, expectedRemaining)
                rawHeaders.removeValue(forKey: ResponseHeader.Key.requestsRemaining.rawValue)

            case .totalNumberOfElements(let amount):
                let expectedTotalNumberOfElements = Int(rawHeaders[ResponseHeader.Key.totalNumberOfElements.rawValue]!)!
                XCTAssertEqual(amount, expectedTotalNumberOfElements)
                rawHeaders.removeValue(forKey: ResponseHeader.Key.totalNumberOfElements.rawValue)

            case .elementsPerPage(let amount):
                let expectedElementsPerPage = Int(rawHeaders[ResponseHeader.Key.elementsPerPage.rawValue]!)!
                XCTAssertEqual(amount, expectedElementsPerPage)
                rawHeaders.removeValue(forKey: ResponseHeader.Key.elementsPerPage.rawValue)
            }
        }

        // Make sure all the expected headers were checked once and only once
        XCTAssertEqual(rawHeaders.count, 0)
    }
}
