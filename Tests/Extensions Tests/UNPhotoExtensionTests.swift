//
//  UNPhotoExtensionTests.swift
//  Unsplash Framework Tests
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


class UNPhotoExtensionTests: XCTestCase
{
    func testColor()
    {
        let hexColorToTest  = "#0033FF"
        let equivalentColor = UIColor(red:0.0, green:0.2, blue:1.0, alpha:1.0)
        
        var validPhoto = DemoData.getValidSamplePhoto()
        validPhoto.hexColor = hexColorToTest
        
        XCTAssert(validPhoto.color == equivalentColor)
    }
    
    
    func testSize()
    {
        let width  = 200
        let height = 300
        let sizeToCompare = CGSize(width: CGFloat(width), height: CGFloat(height))
        
        var validPhoto = DemoData.getValidSamplePhoto()
        validPhoto.width  = width
        validPhoto.height = height
        
        XCTAssert(validPhoto.size == sizeToCompare)
    }
}
