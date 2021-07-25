//
//  UNImageRequester.swift
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

/// Protocol that an object must to conform to in order to make some of the requests.
public protocol UNImageRequester: AnyObject {

    /// Function called when the UNClient has finished with the request.
    ///
    /// - Parameters:
    ///   - photo: The photo that was requested.
    ///   - size: The size of the requested photo.
    ///   - dataImage: The image received from Unsplash if the request was successful.
    ///   - error: If the request failed, the error represents the reason why it failed.
    func clientDidCompleteExclusiveImageRequest(for photo: UNPhoto,
                                                in size: UNPhotoImageSize,
                                                dataImage: Data?,
                                                error: UNError?)
}
