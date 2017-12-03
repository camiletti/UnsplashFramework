//
//  UNPhotoTests.swift
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


import XCTest
@testable import UnsplashFramework


class UNPhotoTests: XCTestCase
{
    func testInequality()
    {
        var photoA = DemoData.getValidSamplePhoto()
        var photoB = photoA
        
        photoA.id = "A"
        photoB.id = "B"
        
        XCTAssert(photoA != photoB, "Photos with same values but different IDs should not be equal")
    }
    
    
    func testHashForSamePhoto()
    {
        let photoA = DemoData.getValidSamplePhoto()
        let photoB = photoA
        
        XCTAssert(photoA.hashValue == photoB.hashValue)
    }
    
    
    func testThatTheHashValueForPhotosWithSameIDIsTheSameEvenIfTheOtherVariablesAreDifferent()
    {
        var photoA = DemoData.getValidSamplePhoto()
        var photoB = DemoData.getInvalidPhoto()
        
        photoA.id = "A"
        photoB.id = "B"
        
        XCTAssert(photoA.hashValue != photoB.hashValue)
    }
    
    
    func testHashForDifferentPhotos()
    {
        var photoA = DemoData.getValidSamplePhoto()
        var photoB = photoA
        
        photoA.id = "A"
        photoB.id = "B"
        
        XCTAssert(photoA.hashValue != photoB.hashValue)
    }
}
