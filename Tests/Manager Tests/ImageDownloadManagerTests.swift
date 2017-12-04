//
//  ImageDownloadManagerTests.swift
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


private let ExpectationTimeout = 60.0


class ImageDownloadManagerTests: XCTestCase
{
    
    // MARK: - Properties
    
    private var imageDownloadManager : ImageDownloadManager!
    
    
    // MARK: - Life cycle
    
    override func setUp()
    {
        super.setUp()
        
        let credentials = UNCredentials(appID: UnsplashKeys.appID, secret: UnsplashKeys.secret)
        self.imageDownloadManager = ImageDownloadManager(withCredentials: credentials)
    }
    
    
    override func tearDown()
    {
        self.imageDownloadManager = nil
        
        super.tearDown()
    }
    
    
    // MARK: - Test fetching images
    
    func testFetchingOneImage()
    {
        let imageAndNoErrorExpectation = expectation(description: "To receive an image and no error")
        
        let samplePhoto = DemoData.getValidSamplePhoto()
        let photoSize = UNPhotoImageSize.full
        
        self.imageDownloadManager.fetchDataImage(for: samplePhoto,
                                                 inSize: photoSize)
        { (requestedPhoto, requestedSize, dataImage, error) in
            
            if  samplePhoto == requestedPhoto,
                requestedSize == photoSize,
                error == nil,
                let dataImage = dataImage,
                UIImage(data: dataImage) != nil
            {
                imageAndNoErrorExpectation.fulfill()
            }
        }
        
        wait(for: [imageAndNoErrorExpectation], timeout: ExpectationTimeout)
    }
    
    
    func testFetchingMultipleImages()
    {
        let photos = DemoData.validMultiplePhotosArray()
        let photoSize = UNPhotoImageSize.small
        
        XCTAssert(photos.count > 1, "The amount of photos should be greater than 1 for this test")
        
        let multipleImageAndNoErrorExpectation = expectation(description: "To receive an image and no error")
        multipleImageAndNoErrorExpectation.expectedFulfillmentCount = photos.count
        
        for photo in photos
        {
            self.imageDownloadManager.fetchDataImage(for: photo,
                                                     inSize: photoSize)
            { (requestedPhoto, requestedSize, dataImage, error) in
                
                if  photo == requestedPhoto,
                    requestedSize == photoSize,
                    error == nil,
                    let dataImage = dataImage,
                    UIImage(data: dataImage) != nil
                {
                    multipleImageAndNoErrorExpectation.fulfill()
                }
            }
        }
        
        wait(for: [multipleImageAndNoErrorExpectation], timeout: ExpectationTimeout)
    }
    
    
    func testFetchingAnImageFromAPhotoNotPointingToUnsplash()
    {
        var invalidPhoto = DemoData.getInvalidPhoto()
        invalidPhoto.imageLinks.smallURL = URL(string: "http://")!
        let photoSize = UNPhotoImageSize.small
        
        let noImageAndServerNotReachErrorExpectation = expectation(description: "To receive no image and an error")
        
        self.imageDownloadManager.fetchDataImage(for: invalidPhoto,
                                                 inSize: photoSize)
        { (requestedPhoto, requestedSize, dataImage, error) in
            
            if  invalidPhoto  == requestedPhoto,
                requestedSize == photoSize,
                dataImage     == nil,
                error?.reason == .serverNotReached
            {
                noImageAndServerNotReachErrorExpectation.fulfill()
            }
        }
        
        wait(for: [noImageAndServerNotReachErrorExpectation], timeout: ExpectationTimeout)
    }
    
    
    func testFetchingAnImageFromAnInvalidPhoto()
    {
        let invalidPhoto = DemoData.getInvalidPhoto()
        let photoSize = UNPhotoImageSize.small
        
        let noImageAndNotFoundErrorExpectation = expectation(description: "To receive no image and not found error")
        
        self.imageDownloadManager.fetchDataImage(for: invalidPhoto,
                                                 inSize: photoSize)
        { (requestedPhoto, requestedSize, dataImage, error) in
            
            if  invalidPhoto == requestedPhoto,
                requestedSize == photoSize,
                error?.reason == UNErrorReason.serverError(.notFound),
                let dataImage = dataImage,
                UIImage(data: dataImage) == nil
            {
                noImageAndNotFoundErrorExpectation.fulfill()
            }
        }
        
        wait(for: [noImageAndNotFoundErrorExpectation], timeout: ExpectationTimeout)
    }
    
    
    func testThatTheFetchingImagesCompletionHandlerIsCalledOnTheMainThreat()
    {
        let completionHandlerOnMainThreadExpectation = expectation(description: "Completion handler called on main thread")
        
        let samplePhoto = DemoData.getValidSamplePhoto()
        
        self.imageDownloadManager.fetchDataImage(for: samplePhoto,
                                                 inSize: .full)
        { (requestedPhoto, requestedSize, dataImage, error) in
            
            if Thread.current == .main
            {
                completionHandlerOnMainThreadExpectation.fulfill()
            }
        }
        
        wait(for: [completionHandlerOnMainThreadExpectation], timeout: ExpectationTimeout)
    }
}
