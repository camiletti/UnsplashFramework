//
//  MockUNPhoto.swift
//  MockUNPhoto
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
@testable import UnsplashFramework

extension UNPhoto {

    static func mock(id: String = "1",
                     creationDate: Date? = Date(timeIntervalSince1970: 10000),
                     updateDate: Date? = Date(timeIntervalSince1970: 11000),
                     width: Int = 100,
                     height: Int = 100,
                     hexColor: String = "#0c2626",
                     blurHash: String = "LnIEkXRkjFxZ_NoJWXR*?boJoLa}",
                     description: String? = "A description",
                     altDescription: String? = "Photo description",
                     numberOfLikes: Int = 1,
                     isLikedByUser: Bool = false,
                     user: UNUser = .mock(),
                     collections: [UNCollection] = [],
                     categories: [UNCategory] = [],
                     statistics: UNPhotoStatistics? = nil,
                     imageURLs: UNPhotoImageURLs = .mock(),
                     apiLocations: UNPhotoAPILocations = .mock()) -> UNPhoto {
        UNPhoto(id: id,
                creationDate: creationDate,
                updateDate: updateDate,
                width: width,
                height: height,
                hexColor: hexColor,
                blurHash: blurHash,
                description: description,
                altDescription: altDescription,
                numberOfLikes: numberOfLikes,
                isLikedByUser: isLikedByUser,
                user: user,
                collections: collections,
                categories: categories,
                statistics: statistics,
                imageURLs: imageURLs,
                apiLocations: apiLocations)
    }
}
