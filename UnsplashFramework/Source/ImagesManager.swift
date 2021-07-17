//
//  ImagesManager.swift
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

/// Fetches the image of a photo.
///
/// Discussion: This class is specially here in case in the future
/// a caching system is implemented. That way the cache would be
/// consulted before creating a network request.
class ImagesManager {

    // MARK: - Properties

    private let imageDownloadManager: ImageDownloadManager

    // MARK: - Life Cycle

    /// Creates a new manager with the specified credentials.
    ///
    /// - Parameter credentials: The Unsplash client credentials.
    init(withCredentials credentials: UNCredentials) {
        imageDownloadManager = ImageDownloadManager(withCredentials: credentials)
    }

    // MARK: - Retrieving images

    /// Fetches the image corresponding to the photo on the specified size.
    ///
    /// - Parameters:
    ///   - photo: The photo to download the image from.
    ///   - size: One of the available sizes for the image to be downloaded.
    ///   - completion: The completion closure to handle the result. The image will be passed as a Data.
    func dataImage(from photo: UNPhoto,
                   inSize size: UNPhotoImageSize,
                   completion: @escaping UNFetchDataImageClosure) {
        imageDownloadManager.fetchDataImage(for: photo,
                                            inSize: size,
                                            completion: completion)
    }

    /// Fetches the image in the specified size that corresponds to the passed photo. The requester will
    /// be called when the image is ready. This function is exclusive since the requester will only have
    /// one active request at a time. Any new request by the same object will cancel the previous one.
    ///
    /// - Parameters:
    ///   - photo: The photo that corresponds to the desired image.
    ///   - size: The size of the image to be downloaded.
    ///   - requester: The object that is interested in the image and the one who will be called back.
    func dataImageExclusivelyRequest(from photo: UNPhoto,
                                     inSize size: UNPhotoImageSize,
                                     for requester: UNImageRequester) {
        imageDownloadManager.fetchDataImageExclusively(from: photo,
                                                       inSize: size,
                                                       for: requester)
    }
}
