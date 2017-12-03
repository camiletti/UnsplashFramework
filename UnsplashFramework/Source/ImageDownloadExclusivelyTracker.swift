//
//  ImageDownloadExclusivelyTracker.swift
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


/// Helper for bookkeeping exclusive image downloads. Keeps associations between a requester
/// and its photo request.
internal class ImageDownloadExclusivelyTracker
{
    
    // MARK: Properties
    
    /// Keeps the photo request for every requester.
    private var requesterOIDToPhotoDictionary = [ObjectIdentifier : PhotoDownloadRequest]()
    
    /// List of requesters to be notified for every photo request.
    private var notificationListForRequests = [PhotoDownloadRequest : [UNImageRequester]]()
    
    /// Lock used to protect the edits to the tracking dictionaries.
    private let edits🔐 = NSLock()
    
    
    // MARK: - Update tracking
    
    /// Keeps track of the request for the photo in the specified size for a particular requester.
    ///
    /// - Parameters:
    ///   - photo: The requested photo.
    ///   - size: The size of the requested photo.
    ///   - requester: The object requesting the photo.
    internal func setPhoto(_ photo: UNPhoto,
                          inSize size: UNPhotoImageSize,
                          beingRequestedBy requester: UNImageRequester)
    {
        self.edits🔐.lock()
        defer { self.edits🔐.unlock() } // As good practice, make sure the 🔐 always gets unlock when the function returns
        
        // Create a photo request tracker
        let photoRequest = PhotoDownloadRequest(photo: photo, size: size)
        
        // Remove the requester from the previous request notification list if it was in one
        if let previousRequest = self.requesterOIDToPhotoDictionary[ObjectIdentifier(requester)]
        {
            self.removeRequester(requester,
                                 fromNotificationListForRequest: previousRequest)
        }
        
        // Update the request the requester is associated with
        self.requesterOIDToPhotoDictionary[ObjectIdentifier(requester)] = photoRequest
        
        // Add the requester to the notification list of the new photo request
        self.addRequester(requester,
                          toNotificationListForRequest: photoRequest)
    }
    
    
    /// Removes the track for the photo and its size.
    ///
    /// - Parameters:
    ///   - photo: Photo to be removed.
    ///   - size: Size of the photo to be removed.
    internal func removePhotoRequest(photo: UNPhoto,
                                     inSize size: UNPhotoImageSize)
    {
        self.edits🔐.lock()
        defer { self.edits🔐.unlock() } // As good practice, make sure the 🔐 always gets unlock when the function returns
        
        // Remove all the requesters
        let photoRequest = PhotoDownloadRequest(photo: photo, size: size)
        if let requesters = self.notificationListForRequests[photoRequest]
        {
            for requester in requesters
            {
                self.requesterOIDToPhotoDictionary[ObjectIdentifier(requester)] = nil
            }
        }
        
        // Clear the list of requesters to be notified
        self.emptyNotificationList(for: photoRequest)
    }
    
    
    // MARK: - Consulting
    
    /// Returns whether or not the photo in that size has being set as being downloaded.
    internal func isPhotoAlreadyRequested(photo: UNPhoto,
                                          inSize size: UNPhotoImageSize) -> Bool
    {
        let photoRequest = PhotoDownloadRequest(photo: photo, size: size)
        return self.notificationListForRequests[photoRequest] != nil
    }
    
    
    /// Returns the request track for the specified requester if it has one associated.
    internal func downloadRequestForRequester(_ requester: UNImageRequester) -> PhotoDownloadRequest?
    {
        return self.requesterOIDToPhotoDictionary[ObjectIdentifier(requester)]
    }
    
    
    /// Returns the object requesting the photo in the specified size.
    internal func requestersForPhoto(_ photo: UNPhoto, inSize size: UNPhotoImageSize) -> [UNImageRequester]?
    {
        let photoRequest = PhotoDownloadRequest(photo: photo, size: size)
        return self.notificationListForRequests[photoRequest]
    }
    
    
    // MARK: - Notification list
    
    /// Adds the requester object to the ones that should be notified when the photo finishes being downloaded.
    private func addRequester(_ requester: UNImageRequester,
                              toNotificationListForRequest photoRequest: PhotoDownloadRequest)
    {
        var requesters = self.notificationListForRequests[photoRequest] ?? [UNImageRequester]()
        requesters.append(requester)
        self.notificationListForRequests[photoRequest] = requesters
    }
    
    /// Removes the requester object from the ones that should be notified when the photo finishes being downloaded.
    private func removeRequester(_ requester: UNImageRequester,
                                 fromNotificationListForRequest photoRequest: PhotoDownloadRequest)
    {
        if  var requesters = self.notificationListForRequests[photoRequest],
            let index = requesters.index(where: { $0 === requester})
        {
            requesters.remove(at: index)
            self.notificationListForRequests[photoRequest] = requesters
        }
    }
    
    
    /// Removes every object from the notification list for the specified request.
    private func emptyNotificationList(for photoRequest: PhotoDownloadRequest)
    {
        self.notificationListForRequests[photoRequest] = nil
    }
}
