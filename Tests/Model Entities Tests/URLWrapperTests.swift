//
//  URLWrapperTests.swift
//  
//
//  Created by Pablo Camiletti on 07/08/2022.
//

@testable import UnsplashFramework
import XCTest

final class URLWrapperTests: XCTestCase {

    func testDecoding() throws {
        let jsonData = DemoData.dataFromJSONFile(named: "URLWrapper")
        let decoder = JSONDecoder.unsplashDecoder
        let urlWrapper = try decoder.decode(UNURLWrapper.self, from: jsonData)

        XCTAssertEqual(urlWrapper.url, URL(string: "https://image.unsplash.com/example")!)
    }
}
