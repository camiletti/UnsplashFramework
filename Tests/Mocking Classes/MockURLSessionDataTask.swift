//
//  MockURLSessionDataTask.swift
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


class MockURLSessionDataTask: URLSessionDataTask
{
    
    // MARK: - Properties
    
    private let mockedData     : Data?
    private let mockedResponse : URLResponse?
    private let mockedError    : Error?
    
    private let completionHandler : (Data?, URLResponse?, Error?) -> Void
    
    /// Simulates the queue where the session task is executed
    private let dispatchQueue = DispatchQueue.global(qos: .background)
    
    
    // MARK: - Initializers
    
    init(mockedData: Data?,
         mockedResponse: URLResponse?,
         mockedError: Error?,
         completion: @escaping (Data?, URLResponse?, Error?) -> Void)
    {
        self.mockedData        = mockedData
        self.mockedResponse    = mockedResponse
        self.mockedError       = mockedError
        self.completionHandler = completion
        
        super.init()
    }
    
    
    // MARK: - Overriden functions
    
    override func resume()
    {
        let simulatedNetworkDelayTime = 1.0
        self.dispatchQueue.asyncAfter(deadline: .now() + simulatedNetworkDelayTime)
        {
            self.completionHandler(self.mockedData,
                                   self.mockedResponse,
                                   self.mockedError)
        }
    }
    
}
