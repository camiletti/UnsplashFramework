//
//  UNClientTests.swift
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


private let ShortExpectationTimeout = 30.0
private let ExpectationTimeout = 60.0
private let LongExpectationTimeout = 120.0


class UNClientTests: XCTestCase
{
    
    // MARK: - Properties
    
    private var client : UNClient!
    
    
    // MARK: - Per test life cycle
    
    override func setUp()
    {
        super.setUp()
        
        self.client = UNClient()
    }
    
    
    override func tearDown()
    {
        self.client = nil
        
        super.tearDown()
    }
    
    
    func configureClient()
    {
        self.client.setAppID(UnsplashKeys.appID, secret: UnsplashKeys.secret)
    }
    
    
    // MARK: - Tests for listing photos
    
    func testListingPublicPhotos()
    {
        self.configureClient()
        
        let popularPhotosExpectation = expectation(description: "Receive list of most popular photos")
        
        self.client.listPhotos(page: 1, sortingBy: .popular)
        { (photos, error) in
            
            if  photos.isEmpty == false,
                error == nil
            {
                popularPhotosExpectation.fulfill()
            }
        }
        
        wait(for: [popularPhotosExpectation], timeout: ExpectationTimeout)
    }
    
    
    func testListingMultiplePublicPhotos()
    {
        self.configureClient()
        
        let listExpectationA = expectation(description: "Receive the list from the first request")
        let listExpectationB = expectation(description: "Receive the list from the second request")
        
        self.client.listPhotos(page: 1, sortingBy: .popular)
        { (photos, error) in
            
            if  photos.isEmpty == false,
                error == nil
            {
                listExpectationA.fulfill()
            }
        }
        
        self.client.listPhotos(page: 2, sortingBy: .latest)
        { (photos, error) in
            
            if photos.isEmpty == false,
                error == nil
            {
                listExpectationB.fulfill()
            }
        }
        
        wait(for: [listExpectationA, listExpectationB], timeout: ExpectationTimeout)
    }
    
    
    func testListingPublicPhotosWithoutCredentials()
    {
        let popularPhotosExpectation = expectation(description: "Receive an error and no photos")
        
        self.client.listPhotos(page: 1, sortingBy: .popular)
        { (photos, error) in
            
            if  photos.isEmpty,
                let error = error,
                error.reason == UNErrorReason.credentialsNotSet
            {
                popularPhotosExpectation.fulfill()
            }
        }
        
        wait(for: [popularPhotosExpectation], timeout: ExpectationTimeout)
    }
    
    
    func testListingPublicPhotosWithInvalidCredentials()
    {
        let popularPhotosExpectation = expectation(description: "Receive an error and no photos")
        self.client.setAppID(UnsplashKeys.invalidAppID, secret: UnsplashKeys.invalidSecret)
        
        self.client.listPhotos(page: 1, sortingBy: .popular)
        { (photos, error) in
            
            if  photos.isEmpty,
                let error = error,
                error.reason == UNErrorReason.serverError(ResponseStatusCode.unauthorized)
            {
                popularPhotosExpectation.fulfill()
            }
        }
        
        wait(for: [popularPhotosExpectation], timeout: ExpectationTimeout)
    }
    
    
    // MARK: - Test fetching images
    
    func testFetchingDataImageOfAValidPhoto()
    {
        self.configureClient()
        
        let imageDataExpectation = expectation(description: "Receive the image data from the photo")
        
        let samplePhoto = DemoData.getValidSamplePhoto()
        let photoSize = UNPhotoImageSize.small
        
        self.client.fetchDataImage(from: samplePhoto,
                                   inSize: photoSize)
        { (requestedPhoto, requestedSize, dataImage, error) in
            
            if  requestedPhoto == samplePhoto,
                photoSize == requestedSize,
                error == nil,
                let dataImage = dataImage,
                dataImage.isImageData
            {
                imageDataExpectation.fulfill()
            }
        }
        
        wait(for: [imageDataExpectation], timeout: ExpectationTimeout)
    }
    
    
    func testFetchingDataImageOfAValidPhotoWithoutCredentials()
    {
        let imageDataExpectation = expectation(description: "Receive an error and no image")
        
        let samplePhoto = DemoData.getValidSamplePhoto()
        let photoSize = UNPhotoImageSize.small
        
        self.client.fetchDataImage(from: samplePhoto,
                                   inSize: photoSize)
        { (requestedPhoto, requestedSize, dataImage, error) in
            
            if  requestedPhoto == samplePhoto,
                photoSize == requestedSize,
                dataImage == nil,
                let error = error,
                error.reason == UNErrorReason.credentialsNotSet
            {
                imageDataExpectation.fulfill()
            }
        }
        
        wait(for: [imageDataExpectation], timeout: ExpectationTimeout)
    }
    
    
    func testFetchingDataImageOfAnInvalidPhoto()
    {
        self.configureClient()
        
        let imageDataExpectation = expectation(description: "Receive no image data and an error")
        
        let invalidPhoto = DemoData.getInvalidPhoto()
        let photoSize = UNPhotoImageSize.raw
        
        self.client.fetchDataImage(from: invalidPhoto,
                                   inSize: photoSize)
        { (requestedPhoto, requestedSize, dataImage, error) in
            
            if  requestedPhoto == invalidPhoto,
                photoSize == requestedSize,
                let error = error,
                error.reason == UNErrorReason.serverError(ResponseStatusCode.notFound)
            {
                imageDataExpectation.fulfill()
            }
        }
        
        wait(for: [imageDataExpectation], timeout: ExpectationTimeout)
    }
    
    
    #if os(iOS) || os(tvOS) || os(watchOS)
    
    func testFetchingImageFromValidPhoto()
    {
        self.configureClient()
        
        let imageDataExpectation = expectation(description: "Receive the image from the photo")
        
        let samplePhoto = DemoData.getValidSamplePhoto()
        let photoSize = UNPhotoImageSize.small
        
        self.client.fetchImage(from: samplePhoto,
                               inSize: photoSize)
        { (requestedPhoto, requestedSize, image, error) in
            
            if  requestedPhoto == samplePhoto,
                photoSize == requestedSize,
                error == nil,
                image != nil
            {
                imageDataExpectation.fulfill()
            }
        }
        
        wait(for: [imageDataExpectation], timeout: ExpectationTimeout)
    }
    
    
    func testFetchingImageFromInvalidPhoto()
    {
        self.configureClient()
        
        let imageDataExpectation = expectation(description: "Should receive an error and no image")
        
        let invalidPhoto = DemoData.getInvalidPhoto()
        let photoSize = UNPhotoImageSize.small
        
        self.client.fetchImage(from: invalidPhoto,
                               inSize: photoSize)
        { (requestedPhoto, requestedSize, image, error) in
            
            if  requestedPhoto == invalidPhoto,
                photoSize == requestedSize,
                image == nil,
                let error = error,
                error.reason == UNErrorReason.serverError(ResponseStatusCode.notFound)
            {
                imageDataExpectation.fulfill()
            }
        }
        
        wait(for: [imageDataExpectation], timeout: ExpectationTimeout)
    }
    
    #endif
    
    
    // MARK: - Test exclusive fetch requests
    
    func testMultipleExclusiveRequestsDoNotCallSameRequesterMoreThanOnce()
    {
        self.configureClient()
        
        let callbackExpectation = expectation(description: "Call back should be with the second photo")
        
        let photosArray = DemoData.validMultiplePhotosArray()
        let firstPhoto  = photosArray[0]
        let secondPhoto = photosArray[1]
        let photoSize   = UNPhotoImageSize.regular
        
        // Create spy delegate object
        let requesterSpy = UNImageRequesterSpy
        { (requestedPhoto, requestedSize, imageData, error) in
            
            if  requestedPhoto == secondPhoto,
                photoSize == requestedSize,
                error == nil
            {
                callbackExpectation.fulfill()
            }
            else
            {
                XCTFail()
            }
        }
        
        self.client.fetchDataImageExclusively(from: firstPhoto,
                                              inSize: photoSize,
                                              for: requesterSpy)
        
        self.client.fetchDataImageExclusively(from: secondPhoto,
                                              inSize: photoSize,
                                              for: requesterSpy)
        
        wait(for: [callbackExpectation], timeout: ExpectationTimeout)
    }
    
    
    func testMultipleSameExclusiveRequestsDoNotCallTheRequesterMoreThanOnce()
    {
        self.configureClient()
        
        let callbackExpectation = expectation(description: "Requester should only be called back once")
        callbackExpectation.expectedFulfillmentCount = 2
        callbackExpectation.isInverted = true
        
        let photo = DemoData.getValidSamplePhoto()
        let photoSize = UNPhotoImageSize.regular
        
        // Create spy delegate object
        let requesterSpy = UNImageRequesterSpy
        { (requestedPhoto, requestedSize, imageData, error) in
            
            if  requestedPhoto == photo,
                photoSize == requestedSize,
                error == nil
            {
                callbackExpectation.fulfill()
            }
        }
        
        self.client.fetchDataImageExclusively(from: photo,
                                              inSize: photoSize,
                                              for: requesterSpy)
        
        self.client.fetchDataImageExclusively(from: photo,
                                              inSize: photoSize,
                                              for: requesterSpy)
        
        wait(for: [callbackExpectation], timeout: ShortExpectationTimeout)
    }
    
    
    func testRequestersWithTheSameExclusiveRequestAreAllCalledBack()
    {
        self.configureClient()
        
        let callbackExpectationA = expectation(description: "Call back to requester A expected")
        let callbackExpectationB = expectation(description: "Call back to requester B expected")
        
        let photo = DemoData.getValidSamplePhoto()
        let photoSize = UNPhotoImageSize.regular
        
        // Create spy delegate object
        let requesterSpyA = UNImageRequesterSpy
        { (requestedPhoto, requestedSize, imageData, error) in
            
            if  requestedPhoto == photo,
                photoSize == requestedSize,
                error == nil
            {
                callbackExpectationA.fulfill()
            }
        }
        
        let requesterSpyB = UNImageRequesterSpy
        { (requestedPhoto, requestedSize, imageData, error) in
            
            if  requestedPhoto == photo,
                photoSize == requestedSize,
                error == nil
            {
                callbackExpectationB.fulfill()
            }
        }
        
        self.client.fetchDataImageExclusively(from: photo,
                                              inSize: photoSize,
                                              for: requesterSpyA)
        
        self.client.fetchDataImageExclusively(from: photo,
                                              inSize: photoSize,
                                              for: requesterSpyB)
        
        wait(for: [callbackExpectationA, callbackExpectationB], timeout: ShortExpectationTimeout)
    }
    
    
    func testMultipleExclusiveRequestsFromDifferentRequesters()
    {
        self.configureClient()
        
        let photosArray = DemoData.validMultiplePhotosArray()
        let photoSize   = UNPhotoImageSize.thumb
        
        let callbacksExpectation = expectation(description: "All the requesters should be called back with the image")
        callbacksExpectation.expectedFulfillmentCount = photosArray.count
        
        for photo in photosArray
        {
            // Create spy delegate object
            let requesterSpy = UNImageRequesterSpy
            { (requestedPhoto, requestedSize, imageData, error) in
                
                if  requestedPhoto == photo,
                    photoSize == requestedSize,
                    imageData != nil,
                    error == nil
                {
                    callbacksExpectation.fulfill()
                }
            }
            
            // Call function to test
            self.client.fetchDataImageExclusively(from: photo,
                                                  inSize: photoSize,
                                                  for: requesterSpy)
        }
        
        wait(for: [callbacksExpectation], timeout: LongExpectationTimeout)
    }
    
    
    func testExclusiveRequestsWithoutCredentials()
    {
        let callbackExpectation = expectation(description: "Call back with an error and no image")
        
        let photo = DemoData.getValidSamplePhoto()
        let photoSize = UNPhotoImageSize.regular
        
        // Create spy delegate object
        let requesterSpy = UNImageRequesterSpy
        { (requestedPhoto, requestedSize, imageData, error) in
            
            if  requestedPhoto == photo,
                requestedSize  == photoSize,
                imageData == nil,
                let error = error,
                error.reason == UNErrorReason.credentialsNotSet
            {
                callbackExpectation.fulfill()
            }
            else
            {
                XCTFail()
            }
        }
        
        self.client.fetchDataImageExclusively(from: photo,
                                              inSize: photoSize,
                                              for: requesterSpy)
        
        wait(for: [callbackExpectation], timeout: ExpectationTimeout)
    }
    
    
    func testThatTheExclusiveRequestComplationHandlerIsCalledOnTheMainThread()
    {
        self.configureClient()
        
        let mainThreadExpectation = expectation(description: "The completion handler should be called on the main thread")
        
        // Create spy delegate object
        let requesterSpy = UNImageRequesterSpy
        { (requestedPhoto, requestedSize, imageData, error) in
            
            if Thread.isMainThread { mainThreadExpectation.fulfill() }
        }
        
        // Photo and size to request
        let samplePhoto = DemoData.getValidSamplePhoto()
        let photoSize = UNPhotoImageSize.small
        
        // Call function to test
        self.client.fetchDataImageExclusively(from: samplePhoto,
                                   inSize: photoSize,
                                   for: requesterSpy)
        
        wait(for: [mainThreadExpectation], timeout: ExpectationTimeout)
    }
    
    
    // MARK: - Test credentials
    
    func testHasCredentialsAfterSettingThem()
    {
        XCTAssert(self.client.hasCredentials == false)
        self.client.setAppID(UnsplashKeys.appID, secret: UnsplashKeys.secret)
        XCTAssert(self.client.hasCredentials == true)
    }
}
