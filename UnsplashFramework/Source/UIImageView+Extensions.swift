//
//  UIImageView+Extensions.swift
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

#if os(iOS) || os(tvOS)

import UIKit

extension UIImageView {
    /// Sets the image from the given photo in the specified size.
    ///
    /// - Parameters:
    ///   - photo: The photo that represents the image to be set.
    ///   - size: The size of the image.
    public func setImage(from photo: UNPhoto, inSize size: UNPhotoImageSize) {
        UNClient.shared.fetchDataImageExclusively(from: photo,
                                                  inSize: size,
                                                  for: self)
    }
}

// MARK: - UNImageRequester
extension UIImageView: UNImageRequester {

    public func clientDidCompleteExclusiveImageRequest(for photo: UNPhoto,
                                                       in size: UNPhotoImageSize,
                                                       dataImage: Data?,
                                                       error: UNError?) {
        if error == nil,
           let dataImage = dataImage,
           let image = UIImage(data: dataImage) {
            self.image = image
        } else {
            print("UIImageView: Couldn't set the image from the photo \(photo) due to:")
            print(String(describing: error))
        }
    }
}

#endif
