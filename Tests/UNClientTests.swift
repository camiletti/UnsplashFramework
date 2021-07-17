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

@testable import UnsplashFramework
import XCTest

final class UNClientTests: XCTestCase {

    private enum Constant {
        static let ShortExpectationTimeout = 30.0
        static let ExpectationTimeout = 60.0
        static let LongExpectationTimeout = 120.0
    }

    // MARK: - Properties

    private var client: UNClient!

    // MARK: - Per test life cycle

    override func setUp() {
        super.setUp()

        client = UNClient()
    }

    override func tearDown() {
        self.client = nil

        super.tearDown()
    }

    func configureClient() {
        client.setAppID(UnsplashKeys.appID, secret: UnsplashKeys.secret)
    }

    // MARK: - Tests for listing photos

    func testListingPublicPhotos() {
        self.configureClient()

        let photosExpectation = expectation(description: "Receive list of most popular photos")
        let completionChecker = self.completionForListingPhotosSuccessfully(expectation: photosExpectation)

        self.client.listPhotos(page: 1, sortingBy: .popular, completion: completionChecker)

        wait(for: [photosExpectation], timeout: Constant.ExpectationTimeout)
    }

    func testListingMultiplePublicPhotos() {
        self.configureClient()

        let listExpectationA = expectation(description: "Receive the list from the first request")
        let listExpectationB = expectation(description: "Receive the list from the second request")

        let completionCheckerA = self.completionForListingPhotosSuccessfully(expectation: listExpectationA)
        let completionCheckerB = self.completionForListingPhotosSuccessfully(expectation: listExpectationB)

        client.listPhotos(page: 1, sortingBy: .popular, completion: completionCheckerA)
        client.listPhotos(page: 2, sortingBy: .latest, completion: completionCheckerB)

        wait(for: [listExpectationA, listExpectationB], timeout: Constant.ExpectationTimeout)
    }

    func testListingPublicPhotosWithoutCredentials() {
        let errorExpectation = expectation(description: "Receive an error and no photos")
        let completionChecker: UNPhotoListClosure = self.completionForQueryWithoutCredentials(expectation: errorExpectation)

        client.listPhotos(page: 1, sortingBy: .popular, completion: completionChecker)

        wait(for: [errorExpectation], timeout: Constant.ExpectationTimeout)
    }

    func testListingPublicPhotosWithInvalidCredentials() {
        client.setAppID(UnsplashKeys.invalidAppID, secret: UnsplashKeys.invalidSecret)

        let errorExpectation = expectation(description: "Receive an error and no photos")
        let completionChecker: UNPhotoListClosure = self.completionForQueryWithInvalidCredentials(expectation: errorExpectation)

        client.listPhotos(page: 1, sortingBy: .popular, completion: completionChecker)

        wait(for: [errorExpectation], timeout: Constant.ExpectationTimeout)
    }

    // MARK: - Tests for searching photos

    func testStandardPhotoSearch() {
        configureClient()
        let photosExpectation = expectation(description: "Receive a successful response with photos")

        let query = "Forest"
        let page = 1
        let photosPerPage = 8

        client.searchPhotos(query: query,
                            page: page,
                            photosPerPage: photosPerPage,
                            collections: nil,
                            orientation: nil) { (result) in
            switch result {
            case .success(let searchResult):
                if searchResult.elements.count <= photosPerPage,
                   !searchResult.elements.isEmpty {
                    photosExpectation.fulfill()
                } else {
                    XCTFail("More photos received in the page than what was asked for.")
                }

            case .failure(let error):
                XCTFail("Request failed with error: \(error.reason)")
            }
        }

        wait(for: [photosExpectation], timeout: Constant.ExpectationTimeout)
    }

    func testSearchingPhotoInCollectionAndWithGivenOrientation() {
        configureClient()
        let photosExpectation = expectation(description: "Receive a successful response with photos")

        let query = "Reflections"
        let page = 1
        let photosPerPage = 8
        let collection = DemoData.validCollection
        let orientation = UNPhotoOrientation.landscape

        client.searchPhotos(query: query,
                            page: page,
                            photosPerPage: photosPerPage,
                            collections: [collection],
                            orientation: orientation) { (result) in
            switch result {
            case .success(let searchResult):
                if searchResult.elements.count <= photosPerPage,
                   !searchResult.elements.isEmpty {
                    photosExpectation.fulfill()
                } else {
                    XCTFail("More photos received in the page than what was asked for.")
                }

            case .failure(let error):
                XCTFail("Request failed with error: \(error.reason)")
            }
        }

        wait(for: [photosExpectation], timeout: Constant.ExpectationTimeout)
    }

    // MARK: - Tests for searching collections

    func testStandardCollectionSearch() {
        configureClient()
        let collectionsExpectation = expectation(description: "Receive a successful response with collections")

        let query = "Forest"
        let page = 1
        let collectionsPerPage = 8

        client.searchCollections(query: query,
                                 page: page,
                                 collectionsPerPage: collectionsPerPage) { (result) in
            switch result {
            case .success(let searchResult):
                if searchResult.elements.count <= collectionsPerPage,
                    !searchResult.elements.isEmpty {
                    collectionsExpectation.fulfill()
                } else {
                    XCTFail("More collections received in the page than what was asked for.")
                }

            case .failure(let error):
                XCTFail("Request failed with error: \(error.reason)")
            }
        }

        wait(for: [collectionsExpectation], timeout: Constant.ExpectationTimeout)
    }

    // MARK: - Tests for searching users

    func testStandardUserSearch() {
        configureClient()
        let usersExpectation = expectation(description: "Receive a successful response with users")

        let query = "Pablo"
        let page = 1
        let usersPerPage = 8

        client.searchUsers(query: query,
                           page: page,
                           usersPerPage: usersPerPage) { (result) in
            switch result {
            case .success(let searchResult):
                if searchResult.elements.count <= usersPerPage,
                   !searchResult.elements.isEmpty {
                    usersExpectation.fulfill()
                } else {
                    XCTFail("More users received in the page than what was asked for.")
                }

            case .failure(let error):
                XCTFail("Request failed with error: \(error.reason)")
            }
        }

        wait(for: [usersExpectation], timeout: Constant.ExpectationTimeout)
    }

    // MARK: - Search

    func testSearchWithoutCredentials() {
        let errorExpectation = expectation(description: "Receive an error and no photos")
        let completionChecker: UNPhotoSearchClosure = completionForQueryWithoutCredentials(expectation: errorExpectation)

        let parameters = UNPhotoSearchParameters(query: "Forest",
                                                 pageNumber: 1,
                                                 photosPerPage: 8,
                                                 collections: nil,
                                                 orientation: nil)

        client.search(.photo,
                      with: parameters,
                      completion: completionChecker)

        wait(for: [errorExpectation], timeout: Constant.ExpectationTimeout)
    }

    func testSearchWithInvalidCredentials() {
        client.setAppID(UnsplashKeys.invalidAppID, secret: UnsplashKeys.invalidSecret)

        let errorExpectation = expectation(description: "Receive an error and no photos")
        let completionChecker: UNPhotoSearchClosure = completionForQueryWithInvalidCredentials(expectation: errorExpectation)

        let parameters = UNPhotoSearchParameters(query: "Forest",
                                                 pageNumber: 1,
                                                 photosPerPage: 8,
                                                 collections: nil,
                                                 orientation: nil)

        client.search(.photo,
                      with: parameters,
                      completion: completionChecker)

        wait(for: [errorExpectation], timeout: Constant.ExpectationTimeout)
    }

    // MARK: - Test fetching images

    func testFetchingDataImageOfAValidPhoto() {
        configureClient()

        let imageDataExpectation = expectation(description: "Receive the image data from the photo")

        let samplePhoto = DemoData.validSamplePhoto
        let photoSize = UNPhotoImageSize.small

        client.fetchDataImage(from: samplePhoto,
                              inSize: photoSize) { (requestedPhoto, requestedSize, dataImage, error) in
            if requestedPhoto == samplePhoto,
               photoSize == requestedSize,
               error == nil,
               let dataImage = dataImage,
               dataImage.isImageData {
                imageDataExpectation.fulfill()
            }
        }

        wait(for: [imageDataExpectation], timeout: Constant.ExpectationTimeout)
    }

    func testFetchingDataImageOfAValidPhotoWithoutCredentials() {
        let imageDataExpectation = expectation(description: "Receive an error and no image")

        let samplePhoto = DemoData.validSamplePhoto
        let photoSize = UNPhotoImageSize.small

        client.fetchDataImage(from: samplePhoto,
                              inSize: photoSize) { (requestedPhoto, requestedSize, dataImage, error) in
            if requestedPhoto == samplePhoto,
               photoSize == requestedSize,
               dataImage == nil,
               let error = error,
               error.reason == UNError.Reason.credentialsNotSet {
                imageDataExpectation.fulfill()
            }
        }

        wait(for: [imageDataExpectation], timeout: Constant.ExpectationTimeout)
    }

    func testFetchingDataImageOfAnInvalidPhoto() {
        configureClient()

        let imageDataExpectation = expectation(description: "Receive no image data and an error")

        let invalidPhoto = DemoData.invalidPhoto
        let photoSize = UNPhotoImageSize.raw

        client.fetchDataImage(from: invalidPhoto,
                              inSize: photoSize) { (requestedPhoto, requestedSize, _, error) in
            if requestedPhoto == invalidPhoto,
               photoSize == requestedSize,
               let error = error,
               error.reason == UNError.Reason.serverError(ResponseStatusCode.notFound) {
                imageDataExpectation.fulfill()
            }
        }

        wait(for: [imageDataExpectation], timeout: Constant.ExpectationTimeout)
    }

    #if os(iOS) || os(tvOS) || os(watchOS)

    func testFetchingImageFromValidPhoto() {
        configureClient()

        let imageDataExpectation = expectation(description: "Receive the image from the photo")

        let samplePhoto = DemoData.validSamplePhoto
        let photoSize = UNPhotoImageSize.small

        client.fetchImage(from: samplePhoto,
                          inSize: photoSize) { (result) in
            switch result {
            case .success(let fetchResult):
                if fetchResult.requestedPhoto == samplePhoto,
                   fetchResult.requestedSize == photoSize {
                    imageDataExpectation.fulfill()
                } else {
                    XCTFail("The requested photo and size doesn't match")
                }

            case .failure(let error):
                XCTFail("fetchImage failed to fetch the image. Reason: \(error.reason)")
            }
        }

        wait(for: [imageDataExpectation], timeout: Constant.ExpectationTimeout)
    }

    func testFetchingImageFromInvalidPhoto() {
        configureClient()

        let imageDataExpectation = expectation(description: "Should receive an error and no image")

        let invalidPhoto = DemoData.invalidPhoto
        let photoSize = UNPhotoImageSize.small

        client.fetchImage(from: invalidPhoto,
                          inSize: photoSize) { (result) in
            switch result {
            case .success(_):
                XCTFail("No image is expected but instead an error")

            case .failure(let error):
                if error.reason == UNError.Reason.serverError(ResponseStatusCode.notFound) {
                    imageDataExpectation.fulfill()
                } else {
                    XCTFail("The returned error is not the expected")
                }
            }
        }

        wait(for: [imageDataExpectation], timeout: Constant.ExpectationTimeout)
    }

    #endif

    // MARK: - Test exclusive fetch requests

    func testMultipleExclusiveRequestsDoNotCallSameRequesterMoreThanOnce() {
        configureClient()

        let callbackExpectation = expectation(description: "Call back should be with the second photo")

        let photosArray = DemoData.validMultiplePhotosArray
        let firstPhoto  = photosArray[0]
        let secondPhoto = photosArray[1]
        let photoSize   = UNPhotoImageSize.regular

        // Create spy delegate object
        let requesterSpy = UNImageRequesterSpy { (requestedPhoto, requestedSize, _, error) in
            if requestedPhoto == secondPhoto,
               photoSize == requestedSize,
               error == nil {
                callbackExpectation.fulfill()
            } else {
                XCTFail()
            }
        }

        client.fetchDataImageExclusively(from: firstPhoto,
                                         inSize: photoSize,
                                         for: requesterSpy)

        client.fetchDataImageExclusively(from: secondPhoto,
                                         inSize: photoSize,
                                         for: requesterSpy)

        wait(for: [callbackExpectation], timeout: Constant.ExpectationTimeout)
    }

    func testMultipleSameExclusiveRequestsDoNotCallTheRequesterMoreThanOnce() {
        configureClient()

        let callbackExpectation = expectation(description: "Requester should only be called back once")
        callbackExpectation.expectedFulfillmentCount = 2
        callbackExpectation.isInverted = true

        let photo = DemoData.validSamplePhoto
        let photoSize = UNPhotoImageSize.regular

        // Create spy delegate object
        let requesterSpy = UNImageRequesterSpy { (requestedPhoto, requestedSize, _, error) in
            if requestedPhoto == photo,
               photoSize == requestedSize,
               error == nil {
                callbackExpectation.fulfill()
            }
        }

        client.fetchDataImageExclusively(from: photo,
                                         inSize: photoSize,
                                         for: requesterSpy)

        client.fetchDataImageExclusively(from: photo,
                                         inSize: photoSize,
                                         for: requesterSpy)

        wait(for: [callbackExpectation], timeout: Constant.ShortExpectationTimeout)
    }

    func testRequestersWithTheSameExclusiveRequestAreAllCalledBack() {
        configureClient()

        let callbackExpectationA = expectation(description: "Call back to requester A expected")
        let callbackExpectationB = expectation(description: "Call back to requester B expected")

        let photo = DemoData.validSamplePhoto
        let photoSize = UNPhotoImageSize.regular

        // Create spy delegate object
        let requesterSpyA = UNImageRequesterSpy { (requestedPhoto, requestedSize, _, error) in
            if requestedPhoto == photo,
               photoSize == requestedSize,
               error == nil {
                callbackExpectationA.fulfill()
            }
        }

        let requesterSpyB = UNImageRequesterSpy { (requestedPhoto, requestedSize, _, error) in
            if requestedPhoto == photo,
               photoSize == requestedSize,
               error == nil {
                callbackExpectationB.fulfill()
            }
        }

        client.fetchDataImageExclusively(from: photo,
                                         inSize: photoSize,
                                         for: requesterSpyA)

        client.fetchDataImageExclusively(from: photo,
                                         inSize: photoSize,
                                         for: requesterSpyB)

        wait(for: [callbackExpectationA, callbackExpectationB], timeout: Constant.ShortExpectationTimeout)
    }

    func testMultipleExclusiveRequestsFromDifferentRequesters() {
        configureClient()

        let photosArray = DemoData.validMultiplePhotosArray
        let photoSize   = UNPhotoImageSize.thumb

        let callbacksExpectation = expectation(description: "All the requesters should be called back with the image")
        callbacksExpectation.expectedFulfillmentCount = photosArray.count

        for photo in photosArray {
            // Create spy delegate object
            let requesterSpy = UNImageRequesterSpy { (requestedPhoto, requestedSize, imageData, error) in
                if requestedPhoto == photo,
                   photoSize == requestedSize,
                   imageData != nil,
                   error == nil {
                    callbacksExpectation.fulfill()
                }
            }

            // Call function to test
            client.fetchDataImageExclusively(from: photo,
                                             inSize: photoSize,
                                             for: requesterSpy)
        }

        wait(for: [callbacksExpectation], timeout: Constant.LongExpectationTimeout)
    }

    func testExclusiveRequestsWithoutCredentials() {
        let callbackExpectation = expectation(description: "Call back with an error and no image")

        let photo = DemoData.validSamplePhoto
        let photoSize = UNPhotoImageSize.regular

        // Create spy delegate object
        let requesterSpy = UNImageRequesterSpy { (requestedPhoto, requestedSize, imageData, error) in
            if requestedPhoto == photo,
               requestedSize == photoSize,
               imageData == nil,
               let error = error,
               error.reason == UNError.Reason.credentialsNotSet {
                callbackExpectation.fulfill()
            } else {
                XCTFail()
            }
        }

        client.fetchDataImageExclusively(from: photo,
                                         inSize: photoSize,
                                         for: requesterSpy)

        wait(for: [callbackExpectation], timeout: Constant.ExpectationTimeout)
    }

    func testThatTheExclusiveRequestComplationHandlerIsCalledOnTheMainThread() {
        configureClient()

        let mainThreadExpectation = expectation(description: "The completion handler should be called on the main thread")

        // Create spy delegate object
        let requesterSpy = UNImageRequesterSpy { (_, _, _, _) in
            if Thread.isMainThread {
                mainThreadExpectation.fulfill()
            }
        }

        // Photo and size to request
        let samplePhoto = DemoData.validSamplePhoto
        let photoSize = UNPhotoImageSize.small

        // Call function to test
        client.fetchDataImageExclusively(from: samplePhoto,
                                         inSize: photoSize,
                                         for: requesterSpy)

        wait(for: [mainThreadExpectation], timeout: Constant.ExpectationTimeout)
    }

    // MARK: - Test credentials

    func testHasCredentialsAfterSettingThem() {
        XCTAssert(client.hasCredentials == false)
        client.setAppID(UnsplashKeys.appID, secret: UnsplashKeys.secret)
        XCTAssert(client.hasCredentials == true)
    }

    // MARK: - Helpers

    private func completionForQueryWithoutCredentials<T: Decodable>(expectation: XCTestExpectation) -> (UNResult<T>) -> Void {
        { (result) in
            switch result {
            case .success(_):
                XCTFail()

            case .failure(let error):
                if error.reason == UNError.Reason.credentialsNotSet {
                    expectation.fulfill()
                }
            }
        }
    }

    private func completionForQueryWithInvalidCredentials<T: Decodable>(expectation: XCTestExpectation) -> (UNResult<T>) -> Void {
        { (result) in
            switch result {
            case .success(_):
                XCTFail()

            case .failure(let error):
                if error.reason == UNError.Reason.serverError(ResponseStatusCode.unauthorized) {
                    expectation.fulfill()
                }
            }
        }
    }

    private func completionForListingPhotosSuccessfully(expectation: XCTestExpectation) -> UNPhotoListClosure {
        { (result) in
            switch result {
            case .success(let photos):
                if photos.isEmpty == false { expectation.fulfill() }

            case .failure(let error):
                XCTFail("\(error.reason)")
            }
        }
    }
}
