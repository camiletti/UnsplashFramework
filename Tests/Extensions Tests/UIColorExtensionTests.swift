//
//  UIColorExtensionTests.swift
//  UnsplashFrameworkTests
//
//  Copyright 2021 Pablo Camiletti
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

final class UIColorExtensionTests: XCTestCase {

    func testInitializationWithValidHexValueOf12Bits() { // RGB
        let hexValue = "#0AF"
        let correctColor = UIColor(red: 0.0 / 255.0, green: 170.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)

        let colorToTest = UIColor(hexString: hexValue)

        XCTAssert(colorToTest.isEqual(correctColor))
    }

    func testInitializationWithValidHexValueOf24Bits() { // RGB
        let hexValue = "#4286f4"
        let correctColor = UIColor(red: 66.0 / 255, green: 134.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0)

        let colorToTest = UIColor(hexString: hexValue)

        XCTAssert(colorToTest.isEqual(correctColor))
    }

    func testInitializationWithValidHexValueOf32Bits() { // ARGB
        let hexValue = "#324286f4"
        let correctColor = UIColor(red: 66.0 / 255, green: 134.0 / 255.0, blue: 244.0 / 255.0, alpha: 50 / 255)

        let colorToTest = UIColor(hexString: hexValue)

        print("\(colorToTest)")

        XCTAssert(colorToTest.isEqual(correctColor))
    }

    func testInitializationWithInvalidHexValue() {
        let hexValue = "#ZZZZZZ"
        let correctColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)

        let colorToTest = UIColor(hexString: hexValue)

        print("\(colorToTest)")

        XCTAssert(colorToTest.isEqual(correctColor))
    }

    func testInitializationWithLongInvalidHexValue() {
        let hexValue = "#324286f48192"
        let correctColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)

        let colorToTest = UIColor(hexString: hexValue)

        print("\(colorToTest)")

        XCTAssert(colorToTest.isEqual(correctColor))
    }
}
