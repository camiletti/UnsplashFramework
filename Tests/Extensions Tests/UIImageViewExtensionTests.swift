//
//  UIImageViewExtensionTests.swift
//  Unsplash Framework iOS Tests
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

final class UIImageViewExtensionTests: XCTestCase {

    override func setUp() {
        super.setUp()
        UNClient.shared.setAppID(UnsplashKeys.appID, secret: UnsplashKeys.secret)
    }

    func testSettingTheImageFromAPhoto() {
        let checkExpectationIsFulfill = 10.0
        let expectationTimeout = checkExpectationIsFulfill + 5.0

        let imageSetExpectation = expectation(description: "Image should be set")

        let photo = DemoData.validSamplePhoto
        let size = UNPhotoImageSize.thumb

        let imageView = UIImageView()

        XCTAssert(imageView.image == nil)
        imageView.setImage(from: photo, inSize: size)

        DispatchQueue.main.asyncAfter(deadline: .now() + checkExpectationIsFulfill) {
            if imageView.image != nil {
                imageSetExpectation.fulfill()
            }
        }

        wait(for: [imageSetExpectation], timeout: expectationTimeout)
    }

    func testSettingTheImageFromAnInvalidPhoto() {
        let checkExpectationIsFulfill = 10.0
        let expectationTimeout = checkExpectationIsFulfill + 10.0

        let imageSetExpectation = expectation(description: "Image should not be set")

        let photo = DemoData.invalidPhoto
        let size = UNPhotoImageSize.thumb

        let imageView = UIImageView()

        XCTAssert(imageView.image == nil)
        imageView.setImage(from: photo, inSize: size)

        DispatchQueue.main.asyncAfter(deadline: .now() + checkExpectationIsFulfill) {
            if imageView.image == nil {
                imageSetExpectation.fulfill()
            }
        }

        wait(for: [imageSetExpectation], timeout: expectationTimeout)
    }
}
