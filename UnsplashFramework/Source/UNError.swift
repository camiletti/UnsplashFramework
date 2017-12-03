//
//  UNError.swift
//  UnsplashFramework
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


/// Struct to represent Unsplash errors to a given query.
public struct UNError : Error
{
    
    // MARK: - Properties
    
    /// Types of things that might go wrong.
    public let reason : UNErrorReason
    
    /// All the reasons Unsplash returned on why the error happened.
    public let reasonDescriptions : [String]
    
    
    /// Creates a new error with the given reason.
    ///
    /// - Parameters:
    ///   - reason: The reason of the error.
    ///   - reasonDescriptions: Optional descriptions of the reason.
    init(reason: UNErrorReason, reasonDescriptions: [String] = [String]())
    {
        self.reason = reason
        self.reasonDescriptions = reasonDescriptions
    }
}


internal extension UNError
{
    /// Checks if the server response is an error or creates one with the passed error
    /// if it's different than nil.
    ///
    /// - Parameters:
    ///   - serverResponse: The response return by the server.
    ///   - error: Connection error if there was one.
    /// - Returns: Creates and returns an error if the parameter passes define one.
    internal static func checkIfItIsAnError(_ serverResponse: URLResponse?, and error: Error?) -> UNError?
    {
        if let requestErrorUnwrapped = error
        {
            return UNError(reason: .serverNotReached,
                           reasonDescriptions: [requestErrorUnwrapped.localizedDescription])
        }
        else if let response = serverResponse
        {
            if let response = response as? HTTPURLResponse
            {
                if response.statusCode != ResponseStatusCode.success.rawValue
                {
                    return UNError(reason: .serverError(ResponseStatusCode(rawValue: response.statusCode)))
                    // TODO: Parse "error" field from response
                }
            }
            else
            {
                return UNError(reason: .unknownServerResponse)
            }
        }
        else
        {
            return UNError(reason: .unknownError)
        }
        
        // No errors
        return nil
    }
}


/// Reasons why a request can fail.
public enum UNErrorReason
{
    /// Couldn't contact Unsplash.
    case serverNotReached
    
    /// Unsplash couldn't fulfill the query. Check the ResponseStatusCode for more info.
    case serverError(ResponseStatusCode?)
    
    /// The data received does not match the expected format.
    case unableToParseDataCorrectly
    
    /// The response from the server could not be parsed.
    case unknownServerResponse
    
    /// No data, no response and no error was received.
    case unknownError
    
    /// AppID and Secret were not previously set.
    case credentialsNotSet
}


extension UNErrorReason: Equatable
{
    /// Returns a Boolean value indicating whether two error reason are equal.
    public static func ==(lhs: UNErrorReason, rhs: UNErrorReason) -> Bool
    {
        switch (lhs, rhs)
        {
        case (.serverNotReached, .serverNotReached),
             (.unableToParseDataCorrectly, .unableToParseDataCorrectly),
             (.unknownServerResponse, .unknownServerResponse),
             (.unknownError, .unknownError),
             (.credentialsNotSet, .credentialsNotSet):
            return true
            
        case (let .serverError(codeA), let .serverError(codeB)):
            return codeA == codeB
            
        default:
            return false
        }
    }
    
    
    /// Returns a Boolean value indicating whether two error reason are not equal.
    public static func !=(lhs: UNErrorReason, rhs: UNErrorReason) -> Bool
    {
        return !(lhs == rhs)
    }
}
