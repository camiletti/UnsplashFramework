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


import Foundation


/// Protocol.
internal let APIScheme   = "https"

/// Location.
///
/// As described at https://unsplash.com/documentation#location
internal let APILocation = "api.unsplash.com"


/// Current version of the API header.
///
/// As described at https://unsplash.com/documentation#version
internal struct APIVersionHeader
{
    /// HTTP header field.
    static let field = "Accept-Version"
    
    /// HTTP header value.
    static let value = "v1"
}


/// Public authentication header.
///
/// As described at https://unsplash.com/documentation#public-actions
internal struct APIAuthorizationHeader
{
    /// HTTP header field.
    static let field = "Authorization"
    
    /// HTTP header value.
    static func value(withAppID appID: String) -> String
    {
        return "Client-ID " + appID
    }
}


/// HTTP accepted verbs.
///
/// As described at https://unsplash.com/documentation#http-verbs
internal enum HTTPMethod : String
{
    /// Method for retrieving resources.
    case get    = "GET"
    
    /// Method for creating resources.
    case post   = "POST"
    
    /// Method for updating resources.
    case put    = "PUT"
    
    /// Method for deleting resources.
    case delete = "DELETE"
}


/// Date format.
/// Example: "created_at": "2015-05-28T10:00:01-04:00".
internal let ResponseDateFormat = "yyyy-MM-dd'T'HH:mm:ss-zz:zz"
