//
//  UNErrorReasonTests.swift
//  UnsplashFramework
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

final class UNErrorReasonTests: XCTestCase {

    // MARK: - Properties

    private let allReasons: [UnsplashFramework.UNError.Reason] = [.serverNotReached,
                                                                  .serverError(nil),
                                                                  .unableToParseDataCorrectly,
                                                                  .unknownServerResponse,
                                                                  .noDataReceived,
                                                                  .credentialsNotSet]

    func testEquality() {
        for i in 0 ..< allReasons.count {
            let reasonA = allReasons[i]
            let reasonB = allReasons[i]

            XCTAssert(reasonA == reasonB)
        }
    }

    func testInequality() {
        for i in 0 ..< allReasons.count - 1 {
            let reason = allReasons[i]

            for j in (i + 1) ..< allReasons.count {
                let reasonToCompare = self.allReasons[j]

                XCTAssert(reason != reasonToCompare)
            }
        }
    }
}
