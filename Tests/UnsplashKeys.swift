//
//  UnsplashKeys.swift
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


import Foundation


/// Provides Unsplash API client keys.
///
/// Discussion: In order to run the tests the following environment variables must be
/// set on the Test Scheme with your personal ApplicationID and Secret from Unsplash.
/// For more info on how to get them please check https://unsplash.com/developers
class UnsplashKeys
{
    
    // MARK: - Valid credentials
    
    class var appID : String
    {
        return ProcessInfo.processInfo.environment["UNSPLASH_APP_ID"]!
    }
    
    
    class var secret : String
    {
        return ProcessInfo.processInfo.environment["UNSPLASH_SECRET"]!
    }
    
    
    // MARK: - Invalid credentials
    
    class var invalidAppID : String
    {
        return ""
    }
    
    
    class var invalidSecret : String
    {
        return ""
    }
}
