//
//  UNPhotoImageURLs.swift
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

/// Accepted sizes of a photo.
public enum UNPhotoImageSize {
    /// Raw size.
    case raw
    /// Full size.
    case full
    /// Regular size.
    case regular
    /// Small size.
    case small
    /// Thumb size.
    case thumb
}

/// Holds the URLs for the same image in different sizes and quality.
public struct UNPhotoImageURLs: Decodable {

    // MARK: - Declarations

    enum CodingKeys: String, CodingKey {
        case rawURL = "raw"
        case fullURL = "full"
        case regularURL = "regular"
        case smallURL = "small"
        case thumbURL = "thumb"
    }

    // MARK: - Properties

    /// Original image without any scaling nor quality reduction.
    public let rawURL: URL

    /// Original size but quality reduction to 85%.
    /// The retrieved image will be jpg.
    public let fullURL: URL

    /// 80% quality and width of 1080 pixels. The height will
    /// be the appropriate maintaining the aspect ratio.
    /// The retrieved image will be jpg.
    public let regularURL: URL

    /// 80% quality and width of 400 pixels. The height will
    /// be the appropriate maintaining the aspect ratio.
    /// The retrieved image will be jpg.
    public let smallURL: URL

    /// 80% quality and width of 200 pixels. The height will
    /// be the appropriate maintaining the aspect ratio.
    /// The retrieved image will be jpg.
    public let thumbURL: URL

    // MARK: - Actions

    /// Convenient function to get the URL for a given size.
    ///
    /// - Parameter size: The desired size.
    /// - Returns: The URL for the specified size.
    func url(forSize size: UNPhotoImageSize) -> URL {
        switch size {
        case .raw:
            return rawURL

        case .full:
            return fullURL

        case .regular:
            return regularURL

        case .small:
            return smallURL

        case .thumb:
            return thumbURL
        }
    }
}
