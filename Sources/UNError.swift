//
//  UNError.swift
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

import Foundation

/// Struct to represent Unsplash errors to a given query.
public struct UNError: Error {

    // MARK: - Declarations

    /// Reasons why a request can fail.
    public enum Reason {

        /// Couldn't contact Unsplash.
        case serverNotReached
        /// Unsplash couldn't fulfil the query. Check the ResponseStatusCode for more info.
        case serverError(ResponseStatusCode?)
        /// The data received does not match the expected format.
        case unableToParseDataCorrectly
        /// The response from the server could not be parsed.
        case unknownServerResponse
        /// No data, no response and no error was received.
        case noDataReceived
        /// AppID and Secret were not previously set.
        case credentialsNotSet
    }

    // MARK: - Properties

    /// Types of things that might go wrong.
    public let reason: Reason

    /// All the reasons Unsplash returned on why the error happened.
    public let reasonDescriptions: [String]

    // MARK: - Life Cycle

    /// Creates a new error with the given reason.
    ///
    /// - Parameters:
    ///   - reason: The reason of the error.
    ///   - reasonDescriptions: Optional descriptions of the reason.
    init(reason: Reason, reasonDescriptions: [String] = [String]()) {
        self.reason = reason
        self.reasonDescriptions = reasonDescriptions
    }

    // MARK: - Helpers

    /// Checks if the server response is an error or creates one with the passed error
    /// if it's different than nil.
    ///
    /// - Parameters:
    ///   - serverResponse: The response return by the server.
    ///   - error: Connection error if there was one.
    /// - Returns: Creates and returns an error if the parameter passes define one.
    static func checkIfItIsAnError(_ serverResponse: URLResponse?, and error: Error?) -> UNError? {
        if let error = error,
           let response = serverResponse as? HTTPURLResponse,
           ResponseStatusCode.isError(code: response.statusCode) {
                return UNError(reason: .serverError(ResponseStatusCode(rawValue: response.statusCode)),
                               reasonDescriptions: [error.localizedDescription])
        } else if let error = error {
            return UNError(reason: .serverNotReached,
                           reasonDescriptions: [error.localizedDescription])
        } else if let response = serverResponse as? HTTPURLResponse,
                  ResponseStatusCode.isError(code: response.statusCode) {
            return UNError(reason: .serverError(ResponseStatusCode(rawValue: response.statusCode)))
        }

        // No errors
        return nil
    }
}

// MARK: - Equatable
extension UNError.Reason: Equatable {

    /// Returns a Boolean value indicating whether two error reason are equal.
    public static func == (lhs: UNError.Reason, rhs: UNError.Reason) -> Bool {
        switch (lhs, rhs) {
        case (.serverNotReached, .serverNotReached),
             (.unableToParseDataCorrectly, .unableToParseDataCorrectly),
             (.unknownServerResponse, .unknownServerResponse),
             (.noDataReceived, .noDataReceived),
             (.credentialsNotSet, .credentialsNotSet):
            return true

        case (let .serverError(codeA), let .serverError(codeB)):
            return codeA == codeB

        default:
            return false
        }
    }

    /// Returns a Boolean value indicating whether two error reason are not equal.
    public static func != (lhs: UNError.Reason, rhs: UNError.Reason) -> Bool {
        !(lhs == rhs)
    }
}
