//
//  UNPhotoAPILocations.swift
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

/// Holds the API URLs for a photo.
public struct UNPhotoAPILocations: Decodable, Equatable {

    // MARK: - Declarations

    enum CodingKeys: String, CodingKey {
        case apiPhotoURL = "self"
        case apiDownloadURL = "download_location"
        case externalPhotoURL = "html"
        case externalDownloadURL = "download"
    }

    // MARK: - Properties

    /// Photo URL. Accessible only through the API.
    public var apiPhotoURL: URL

    /// Download photo URL. Accessible only through the API.
    public var apiDownloadURL: URL

    /// Public link to the photo.
    public var externalPhotoURL: URL

    /// Public download link to the photo.
    public var externalDownloadURL: URL
}
