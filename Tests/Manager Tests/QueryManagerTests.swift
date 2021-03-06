//
//  QueryManagerTests.swift
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


private let ExpectationTimeout = 30.0


class QueryManagerTests: XCTestCase
{
    
    // MARK: - Properties
    
    private var queryManager : QueryManager!
    private let credentials  = UNCredentials(appID: UnsplashKeys.appID, secret: UnsplashKeys.secret)
    private var urlSessionSimulationQueue : DispatchQueue!
    
    
    // MARK: - Life cycle
    
    override func setUp()
    {
        super.setUp()
        
        self.queryManager = QueryManager(withCredentials: self.credentials)
        self.urlSessionSimulationQueue = DispatchQueue(label: "")
    }
    
    
    override func tearDown()
    {
        self.queryManager = nil
        self.urlSessionSimulationQueue = nil
        
        super.tearDown()
    }
    
    
    // MARK: - Test searching photos
    
    func testSearchingReturnsUnexpectedData()
    {
        let dataExpectation = expectation(description: "The data received doesn't match the expected JSON format")
        
        let mockSession  = MockURLSession(mocking: .unexpectedData)
        let queryManager = QueryManager(with: self.credentials, session: mockSession)
        let parameters   = UNPhotoSearchParameters(query: "Forest",
                                                   pageNumber: 1,
                                                   photosPerPage: 10,
                                                   collections: nil,
                                                   orientation: nil)
        
        let completion : UNPhotoSearchClosure =
        { (result) in
            
            switch result
            {
            case .success(_):
                XCTFail("The result should not be successful")
                
            case .failure(let error):
                if error.reason == UNErrorReason.unableToParseDataCorrectly
                {
                    dataExpectation.fulfill()
                }
                else { XCTFail("The reason of the error is incorrect") }
            }
        }
        
        queryManager.search(SearchType.photo, with: parameters, completion: completion)
        
        
        wait(for: [dataExpectation], timeout: ExpectationTimeout)
    }
    
    
    // MARK: - Test processing listing photos
    
    func testProcessingListingPhotosWhenServerWasNotReached()
    {
        let expectedError = UNError(reason:.serverNotReached)
        let requestError = NSError(domain: "", code: 9999999, userInfo: nil)
        self.helpTestProcessingListingPhotosErrors(data: nil,
                                                   fakeServerResponse: nil,
                                                   requestError: requestError,
                                                   expectedError: expectedError)
    }
    
    
    func testProcessingListingPhotosWhenStatusCodeIsNotSuccessful()
    {
        let data = "Garbage data".data(using: .utf8)
        let serverResponse = HTTPURLResponse(url: URL(string: APILocation)!,
                                             statusCode: ResponseStatusCode.unprocessableEntity.rawValue,
                                             httpVersion: nil,
                                             headerFields: nil)
        let expectedError = UNError(reason: .serverError(.unprocessableEntity))
        self.helpTestProcessingListingPhotosErrors(data: data,
                                                   fakeServerResponse: serverResponse,
                                                   requestError: nil,
                                                   expectedError: expectedError)
    }
    
    
    func testProcessingListingPhotosWhenUnexpectedDataIsReceived()
    {
        let data = "Garbage data".data(using: .utf8)
        let serverResponse = HTTPURLResponse(url: URL(string: APILocation)!,
                                             statusCode: ResponseStatusCode.success.rawValue,
                                             httpVersion: nil,
                                             headerFields: nil)
        let expectedError = UNError(reason: .unableToParseDataCorrectly)
        self.helpTestProcessingListingPhotosErrors(data: data,
                                                   fakeServerResponse: serverResponse,
                                                   requestError: nil,
                                                   expectedError: expectedError)
    }
    
    
    func testProcessingListingPhotosWhenUnexpectedResponseIsReceived()
    {
        let expectedError = UNError(reason: .unknownServerResponse)
        self.helpTestProcessingListingPhotosErrors(data: "Garbage data".data(using: .utf8),
                                                   fakeServerResponse: URLResponse(),
                                                   requestError: nil,
                                                   expectedError: expectedError)
    }
    
    
    func testProcessingListingPhotosWhenNoDataNoResponseAndNoErrorAreReceived()
    {
        let expectedError = UNError(reason: .unknownError)
        self.helpTestProcessingListingPhotosErrors(data: nil,
                                                   fakeServerResponse: nil,
                                                   requestError: nil,
                                                   expectedError: expectedError)
    }
    
    
    func helpTestProcessingListingPhotosErrors(data: Data?,
                                               fakeServerResponse: URLResponse?,
                                               requestError: Error?,
                                               expectedError: UNError)
    {
        // Expectations
        let noPhotosAndAnErrorExpectation = expectation(description: "To receive an empty array of photos and an error")
        
        // Parameters
        let completionHandler : UNPhotoListClosure =
        { (result) in
            
            switch result {
            case .success(_):
                XCTFail()
                
            case .failure(let error):
                if error.reason == expectedError.reason
                // We don't care about the reason description in this case
                {
                    noPhotosAndAnErrorExpectation.fulfill()
                }
            }
        }
        
        // Simulate URLSession independent thread
        let workItem = DispatchWorkItem
        {
            // Function to test
            self.queryManager.processResponse(data: data,
                                              response: fakeServerResponse,
                                              requestError: requestError,
                                              decodableProtocol: [UNPhoto].self,
                                              completion: completionHandler)
        }
        
        self.urlSessionSimulationQueue.async(execute: workItem)
        
        wait(for: [noPhotosAndAnErrorExpectation], timeout: ExpectationTimeout)
        if workItem.isCancelled == false { workItem.cancel() }
    }
    
    
    func testThatTheCompletionHandlerOfProcessListingPhotosResponseIsExecutedOnTheMainThread()
    {
        // Expectations
        let executionOnMainThreadExpectation = expectation(description: "Completion block executed on the main thread")
        
        // Parameters
        let completionHandler : UNPhotoListClosure = { (_) in
            if Thread.isMainThread { executionOnMainThreadExpectation.fulfill() }
        }
        
        // Simulate URLSession independent thread
        let workItem = DispatchWorkItem
        {
            self.queryManager.processResponse(data: nil,
                                              response: nil,
                                              requestError: nil,
                                              decodableProtocol: [UNPhoto].self,
                                              completion: completionHandler)
        }
        self.urlSessionSimulationQueue.async(execute: workItem)
        
        // Check
        wait(for: [executionOnMainThreadExpectation], timeout: ExpectationTimeout)
        
        // Clean up
        if workItem.isCancelled == false { workItem.cancel() }
    }
}
