//
//  JSONParsingTests.swift
//  UnsplashFrameworkTests
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


class JSONParsingTests: XCTestCase
{
    
    func testStandardJSONPhotoListParsing()
    {
        let data = DemoData.standardPhotoListResponse()
        var photosArray : [UNPhoto]? = nil
        
        do { photosArray = try JSONDecoder().decode([UNPhoto].self, from: data) }
        catch let error { print(error) }
        
        XCTAssertNotNil(photosArray)
        XCTAssert(photosArray!.count == 10)
    }
    
    
    func testJSONPhotoListWithCollectionAndCategoryParsing()
    {
        let data = DemoData.photoListOfPhotosBelongingToCollections()
        var photosArray : [UNPhoto]? = nil
        
        do { photosArray = try JSONDecoder().decode([UNPhoto].self, from: data) }
        catch let error { print(error) }
        
        XCTAssertNotNil(photosArray)
        XCTAssertNotNil(photosArray?.first?.collections)
        XCTAssertNotNil(photosArray?.first?.collections.first?.coverPhoto?.categories)
    }
}
