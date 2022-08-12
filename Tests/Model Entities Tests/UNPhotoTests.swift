//
//  UNPhotoTests.swift
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

final class UNPhotoTests: XCTestCase {

    func testDecoding() throws {
        let jsonData = DemoData.dataFromJSONFile(named: "Photo")
        let decoder = JSONDecoder.unsplashDecoder
        let photo = try decoder.decode(UNPhoto.self, from: jsonData)

        XCTAssertEqual(photo.id, "DSpHm6LMSHA")
        XCTAssertNotNil(photo.creationDate)
        XCTAssertNotNil(photo.updateDate)
        XCTAssertNotNil(photo.promotedDate)
        XCTAssertEqual(photo.width, 5456)
        XCTAssertEqual(photo.height, 3064)
        XCTAssertEqual(photo.hexColor, "#d9d9d9")
        XCTAssertEqual(photo.description, "Superman flying over NYC")
        XCTAssertEqual(photo.altDescription, "2 fists are seeing over New York's sky pretending to be Superman flying")
        XCTAssertEqual(photo.numberOfLikes, 427)
        XCTAssertFalse(photo.isLikedByUser)
        XCTAssertEqual(photo.collections, [])
        XCTAssertEqual(photo.categories, [])
    }

    func testDecodingUserPhotos() throws {
        let jsonData = DemoData.dataFromJSONFile(named: "UserPhotos")
        let decoder = JSONDecoder.unsplashDecoder
        let photos = try decoder.decode([UNPhoto].self, from: jsonData)

        // A property that can specially be requested in user photos is statistics
        // so we'll make sure it's decoded
        photos.forEach { XCTAssertNotNil($0.statistics) }
    }

    func testInequality() {
        var photoA = DemoData.validSamplePhoto
        var photoB = photoA

        photoA.id = "A"
        photoB.id = "B"

        XCTAssert(photoA != photoB, "Photos with same values but different IDs should not be equal")
    }

    func testHashForSamePhoto() {
        let photoA = DemoData.validSamplePhoto
        let photoB = photoA

        XCTAssert(photoA.hashValue == photoB.hashValue)
    }

    func testThatTheHashValueForPhotosWithSameIDIsTheSameEvenIfTheOtherVariablesAreDifferent() {
        var photoA = DemoData.validSamplePhoto
        var photoB = DemoData.invalidPhoto

        photoA.id = "A"
        photoB.id = "B"

        XCTAssert(photoA.hashValue != photoB.hashValue)
    }

    func testHashForDifferentPhotos() {
        var photoA = DemoData.validSamplePhoto
        var photoB = photoA

        photoA.id = "A"
        photoB.id = "B"

        XCTAssert(photoA.hashValue != photoB.hashValue)
    }
}
