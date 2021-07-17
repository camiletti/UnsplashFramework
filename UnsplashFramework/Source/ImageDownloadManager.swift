//
//  ImageDownloadManager.swift
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

final class ImageDownloadManager {

    // MARK: - Declarations

    private enum Constant {
        static let operationQueueMaxConcurrency = 2
    }

    // MARK: - Properties

    /// Unsplash client credentials.
    private let credentials: UNCredentials

    /// Session used for fetching the images.
    private let urlSession: URLSession

    /// Queue to handle every fetch request.
    private let fetchQueue = OperationQueue()

    /// Keeps track of all the exclusive image downloads and who requested them.
    private let exclusiveDownloadTracker = ImageDownloadExclusivelyTracker()

    /// Makes sure the fetchDataImageExclusively(from:inSize:for:) function runs atomically.
    private let fetchDataImageExclusively🔐 = NSLock()

    // MARK: - Initializers

    /// Creates a new manager with the specified credentials.
    ///
    /// - Parameter credentials: Unsplash client credentials.
    init(withCredentials credentials: UNCredentials,
         urlSession: URLSession = URLSession(configuration: .default),
         maxConcurrentOperationCount: Int = Constant.operationQueueMaxConcurrency) {
        self.credentials = credentials
        self.urlSession = urlSession
        self.fetchQueue.maxConcurrentOperationCount = maxConcurrentOperationCount
    }

    // MARK: - Fetching images from a photo

    /// Fetches the image corresponding to the photo in the specified size and calls the
    /// completion handler when it's ready.
    ///
    /// - Parameters:
    ///   - photo: The photo to download the image from.
    ///   - size: One of the available sizes for the image to be downloaded.
    ///   - completion: The completion closure to handle the result. The image will be passed as a Data.
    func fetchDataImage(for photo: UNPhoto,
                        inSize size: UNPhotoImageSize,
                        completion: @escaping UNFetchDataImageClosure) {
        // Create the fetch data task
        let url = photo.imageLinks.url(forSize: size)

        let processingResponseClosure = { (data: Data?, response: URLResponse?, requestError: Error?) in
                let error = UNError.checkIfItIsAnError(response, and: requestError)
                DispatchQueue.main.async { completion(photo, size, data, error) }
            }

        let task = urlSession.dataTask(with: url,
                                       completionHandler: processingResponseClosure)

        // Add the fetch operation to the queue
        let taskOperation = URLSessionTaskOperation(with: task)
        fetchQueue.addOperation(taskOperation)
    }

    /// Downloads the image and calls the requester when ready. This function is exclusive since the
    /// requester will only have one active request at a time. Any new request by the same object
    /// will cancel the previous one.
    ///
    /// - Parameters:
    ///   - photo: The photo that corresponds to the desired image.
    ///   - size: The size of the image to be downloaded.
    ///   - requester: The object that is interested in the image and the one who will be called back.
    func fetchDataImageExclusively(from photo: UNPhoto,
                                   inSize size: UNPhotoImageSize,
                                   for requester: UNImageRequester) {
        // At any point of return in the function, unlock the 🔐
        defer { self.fetchDataImageExclusively🔐.unlock() }

        // Start the execution atomically
        fetchDataImageExclusively🔐.lock()

        // Make sure the photo in that size is not already requested by the same requester
        if  let downloadRequest = exclusiveDownloadTracker.downloadRequestForRequester(requester),
            downloadRequest.photo.id == photo.id,
            downloadRequest.size == size {
            return
        }

        // Photo in that size is already being downloaded by another requester
        if exclusiveDownloadTracker.isPhotoAlreadyRequested(photo: photo, inSize: size) {
            // Add the new requester to the notification list for that photo and return
            exclusiveDownloadTracker.setPhoto(photo, inSize: size, beingRequestedBy: requester)
            return
        }

        // The photo in that size is not currently being downloaded
        exclusiveDownloadTracker.setPhoto(photo, inSize: size, beingRequestedBy: requester)
        fetchDataImage(for: photo,
                       inSize: size) { (_: UNPhoto, _: UNPhotoImageSize, dataImage: Data?, error: UNError?) in
            if let requesters = self.exclusiveDownloadTracker.requestersForPhoto(photo, inSize: size) {
                requesters.forEach({ $0.clientDidCompleteExclusiveImageRequest(for: photo,
                                                                               in: size,
                                                                               dataImage: dataImage,
                                                                               error: error) })
            }

            // Update tracker
            self.exclusiveDownloadTracker.removePhotoRequest(photo: photo, inSize: size)
        }
    }
}
