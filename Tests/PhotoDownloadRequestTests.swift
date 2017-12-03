//
//  PhotoDownloadRequestTests.swift
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


class PhotoDownloadRequestTests: XCTestCase
{
    func testEqualityWithEqualPhotoAndSize()
    {
        let photo = DemoData.getValidSamplePhoto()
        let photoSize = UNPhotoImageSize.full
        
        let photoRequestA = PhotoDownloadRequest(photo: photo, size: photoSize)
        let photoRequestB = PhotoDownloadRequest(photo: photo, size: photoSize)
        
        XCTAssert(photoRequestA == photoRequestB)
    }
    
    
    func testEqualityWithDifferentPhotosButSameSize()
    {
        let photosArray = DemoData.validMultiplePhotosArray()
        let photoSize = UNPhotoImageSize.full
        
        let photoRequestA = PhotoDownloadRequest(photo: photosArray[0], size: photoSize)
        let photoRequestB = PhotoDownloadRequest(photo: photosArray[1], size: photoSize)
        
        XCTAssert((photoRequestA == photoRequestB) == false)
    }
    
    
    func testEqualityWithTheSamePhotosButDifferentSize()
    {
        let photo = DemoData.getValidSamplePhoto()
        
        let photoRequestA = PhotoDownloadRequest(photo: photo, size: .raw)
        let photoRequestB = PhotoDownloadRequest(photo: photo, size: .full)
        
        XCTAssert((photoRequestA == photoRequestB) == false)
    }
    
    
    func testInequalityWithEqualPhotoAndSize()
    {
        let photo = DemoData.getValidSamplePhoto()
        let photoSize = UNPhotoImageSize.full
        
        let photoRequestA = PhotoDownloadRequest(photo: photo, size: photoSize)
        let photoRequestB = PhotoDownloadRequest(photo: photo, size: photoSize)
        
        XCTAssert((photoRequestA != photoRequestB) == false)
    }
    
    
    func testInequalityWithDifferentPhotosButSameSize()
    {
        let photosArray = DemoData.validMultiplePhotosArray()
        let photoSize = UNPhotoImageSize.full
        
        let photoRequestA = PhotoDownloadRequest(photo: photosArray[0], size: photoSize)
        let photoRequestB = PhotoDownloadRequest(photo: photosArray[1], size: photoSize)
        
        XCTAssert(photoRequestA != photoRequestB)
    }
    
    
    func testInequalityWithTheSamePhotosButDifferentSize()
    {
        let photo = DemoData.getValidSamplePhoto()
        
        let photoRequestA = PhotoDownloadRequest(photo: photo, size: .raw)
        let photoRequestB = PhotoDownloadRequest(photo: photo, size: .full)
        
        XCTAssert(photoRequestA != photoRequestB)
    }
    
}
