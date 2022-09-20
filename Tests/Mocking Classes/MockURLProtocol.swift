//
//  UnsplashFramework
//
//  Copyright Pablo Camiletti
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

final class MockURLProtocol: URLProtocol {

    // MARK: - Properties

    private static var mockedData: Data?

    private static var mockedResponse: HTTPURLResponse?

    private static var mockedError: Error?

    private static var deadline: TimeInterval = 0

    private static let dispatchQueue = DispatchQueue.global(qos: .background)

    // MARK: - Life Cycle

    static func setup(mockedData: Data?,
                      mockedResponse: HTTPURLResponse?,
                      mockedError: Error?,
                      deadline: TimeInterval) {
        self.mockedData = mockedData
        self.mockedResponse = mockedResponse
        self.mockedError = mockedError
        self.deadline = deadline
    }

    // MARK: - Mocking

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        false
    }

    override func startLoading() {
        Thread.sleep(forTimeInterval: MockURLProtocol.deadline)

        // Set mocked data
        if let mockedData = MockURLProtocol.mockedData {
            client?.urlProtocol(self, didLoad: mockedData)
            MockURLProtocol.mockedData = nil
        }

        // Set mocked response
        if let mockedResponse = MockURLProtocol.mockedResponse {
            client?.urlProtocol(self, didReceive: mockedResponse, cacheStoragePolicy: .notAllowed)
            MockURLProtocol.mockedResponse = nil
        }

        // Set mocked error
        if let mockedError = MockURLProtocol.mockedError {
            self.client?.urlProtocol(self, didFailWithError: mockedError)
            MockURLProtocol.mockedError = nil
        } else {
            // Report loading has finished after the simulated amount of time
            self.client?.urlProtocolDidFinishLoading(self)
        }
    }

    override func stopLoading() {
        MockURLProtocol.mockedData = nil
        MockURLProtocol.mockedResponse = nil
        MockURLProtocol.mockedError = nil
    }
}
