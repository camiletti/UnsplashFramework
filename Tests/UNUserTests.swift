//
//  UNUserTests.swift
//  UnsplashFramework
//
//  Copyright 2017 Pablo Camiletti
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

final class UNUserTests: XCTestCase {

    func testEquality() {
        var userA = DemoData.invalidUser
        var userB = userA

        XCTAssert(userA == userB)
        XCTAssert(userB == userA)

        userA.id = "A"
        userB.id = "B"

        XCTAssert((userA == userB) == false)
        XCTAssert((userB == userA) == false)
    }

    func testInequality() {
        var userA = DemoData.invalidUser
        var userB = userA

        XCTAssert((userA != userB) == false)
        XCTAssert((userB != userA) == false)

        userA.id = "A"
        userB.id = "B"

        XCTAssert(userA != userB)
        XCTAssert(userB != userA)
    }

    func testProfileImage() {
        let userAPILocations = DemoData.invalidUserAPILocations
        var user = DemoData.invalidUser
        user.apiLocations = userAPILocations

        XCTAssert(user.profileURL == userAPILocations.externalProfileURL)
    }
}
