//
//  MockURLSession.swift
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


import Foundation
@testable import UnsplashFramework


enum MockedCondition
{
    case unexpectedData
}


class MockURLSession: URLSession
{
    
    // MARK: - Properties
    
    private let mockedCondition : MockedCondition
    
    
    // MARK: Initializers
    
    init(mocking mockedCondition: MockedCondition)
    {
        self.mockedCondition = mockedCondition
        
        super.init()
    }
    
    
    // MARK: - Mocked dataTask functions
    
    override func dataTask(with request: URLRequest,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    {
        switch self.mockedCondition
        {
        case .unexpectedData:
            let mockedData = self.unexpectedJSONData()
            let mockedResponse = self.successHTTPResponse(with: request.url!)
            return MockURLSessionDataTask(mockedData: mockedData,
                                          mockedResponse: mockedResponse,
                                          mockedError: nil,
                                          completion: completionHandler)
        }
    }
    
    
    // MARK: - Unmocked dataTask functions
    
    override func dataTask(with request: URLRequest) -> URLSessionDataTask
    {
        fatalError("MockURLSession: Function was not mocked yet")
    }
    
    
    override func dataTask(with url: URL) -> URLSessionDataTask
    {
        fatalError("MockURLSession: Function was not mocked yet")
    }
    
    
    override func dataTask(with url: URL,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    {
        fatalError("MockURLSession: Function was not mocked yet")
    }
    
    
    // MARK: - Helpers
    
    private func successHTTPResponse(with url: URL) -> HTTPURLResponse
    {
        return HTTPURLResponse(url: url,
                               statusCode: ResponseStatusCode.success.rawValue,
                               httpVersion: nil,
                               headerFields: ["Content-Type" : "application/json"])!
    }
    
    
    private func unexpectedJSONData() -> Data
    {
        return "!(#£$^&*^%$£@".data(using: .utf8)!
    }
    
}
