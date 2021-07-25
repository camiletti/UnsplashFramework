//
//  URLSessionTaskOperationTests.swift
//  UnsplashFramework
//
//  Copyright 2021 Pablo Camiletti
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

final class URLSessionTaskOperationTests: XCTestCase {

    // MARK: - Declarations

    enum Constant {
        static let expectationTimeout = 10.0
    }

    // MARK: - Properties

    private var session: URLSession!

    private var operationQueue: OperationQueue!

    override func setUpWithError() throws {
        try super.setUpWithError()

        session = URLSession(configuration: .default)
        operationQueue = OperationQueue()
    }

    override func tearDownWithError() throws {
        session.invalidateAndCancel()
        session = nil

        operationQueue.cancelAllOperations()
        operationQueue = nil

        try super.tearDownWithError()
    }

    func testTheOperationIsAsynchronous() {
        let url = URL(string: "https://httpbin.org/image/jpeg")!
        let task = self.session.dataTask(with: url)
        let taskOperation = URLSessionTaskOperation(with: task)

        XCTAssertTrue(taskOperation.isAsynchronous, "URLSessionTaskOperation are thought to be async")
    }

    func testCancelingAnOperation() {
        let url = URL(string: "https://httpbin.org/image/jpeg")!
        let task = self.session.dataTask(with: url)
        let taskOperation = URLSessionTaskOperation(with: task)

        operationQueue.isSuspended = true
        operationQueue.addOperation(taskOperation)
        taskOperation.cancel()

        XCTAssertTrue(taskOperation.isCancelled)
    }

    func testStartingAnOperationAfterItWasCancelled() {
        let exp = expectation(description: "Completion handler should be called with a cancel error")

        let url = URL(string: "https://httpbin.org/image/jpeg")!
        let task = self.session.dataTask(with: url) { (data, response, error) in
            if data == nil,
               response == nil,
               let error = error as NSError?,
               error.code == NSURLErrorCancelled {
                exp.fulfill()
            }
        }

        let taskOperation = URLSessionTaskOperation(with: task)

        operationQueue.isSuspended = true
        operationQueue.addOperation(taskOperation)

        taskOperation.cancel()
        operationQueue.isSuspended = false

        XCTAssertTrue(taskOperation.isCancelled)

        wait(for: [exp], timeout: Constant.expectationTimeout)
    }
}
