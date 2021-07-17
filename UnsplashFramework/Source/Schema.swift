//
//  Schema.swift
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

enum APIComponent {
    /// Protocol.
    static let scheme = "https"

    /// Location.
    ///
    /// As described at https://unsplash.com/documentation#location
    static let location = "api.unsplash.com"
}

/// Current version of the API header.
///
/// As described at https://unsplash.com/documentation#version
enum APIVersionHeader {
    /// HTTP header field.
    static let field = "Accept-Version"

    /// HTTP header value.
    static let value = "v1"
}

/// Public authentication header.
///
/// As described at https://unsplash.com/documentation#public-actions
enum APIAuthorizationHeader {
    /// HTTP header field.
    static let field = "Authorization"

    /// HTTP header value.
    static func value(withAppID appID: String) -> String {
        "Client-ID \(appID)"
    }
}

/// HTTP accepted verbs.
///
/// As described at https://unsplash.com/documentation#http-verbs
enum HTTPMethod: String {
    /// Method for retrieving resources.
    case get = "GET"
    /// Method for creating resources.
    case post = "POST"
    /// Method for updating resources.
    case put = "PUT"
    /// Method for deleting resources.
    case delete = "DELETE"
}
