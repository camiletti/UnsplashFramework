//
//  UnsplashFramework.swift
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
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#endif


/// The UNClient is the point of access to every Unsplash request.
public class UNClient
{
    
    // MARK: - Properties
    
    /// Returns a shared singleton object.
    public static let shared = UNClient()
    
    /// Unsplash client credentials.
    private var credentials : UNCredentials?
    
    /// Boolean value indicating whether the credentials have been set.
    public  var hasCredentials : Bool
    {
        return self.credentials != nil
    }
    
    private var _queryManager  : QueryManager?
    private var _imagesManager : ImagesManager?
    
    private var queryManager  : QueryManager?
    {
        if  let credentials = self.credentials,
            self._queryManager == nil
        {
            self._queryManager = QueryManager(withCredentials: credentials)
            return self._queryManager
        }
        
        return self._queryManager
    }
    
    private var imagesManager : ImagesManager?
    {
        if  let credentials = self.credentials,
            self._imagesManager == nil
        {
            self._imagesManager = ImagesManager(withCredentials: credentials)
            return self._imagesManager
        }
        
        return self._imagesManager
    }
    
    
    // MARK: - Credentials
    
    /// Sets the credentials for the Unsplash client. This function should only be called once.
    ///
    /// - Parameters:
    ///   - appID: The application ID Unsplash provided you with.
    ///   - secret: The secret Unsplash provided you with.
    public func setAppID(_ appID: String, secret: String)
    {
        if self.credentials == nil
        {
            self.credentials = UNCredentials(appID: appID, secret: secret)
        }
        else
        {
            print("☝️UNClient: AppID and Secret should only be set once. Resetting will be ignored.")
        }
    }
    
    
    // MARK: - Listing photos
    
    /// Get a single page from the list of all photos.
    ///
    /// - Parameters:
    ///   - page: Page number to retrieve.
    ///   - photosPerPage: Number of items per page.
    ///   - sort: How to sort the photos.
    ///   - completion: The completion handler that will be called with the results (Executed on the main thread).
    public func listPhotos(page: Int,
                           photosPerPage: Int = 10,
                           sortingBy sort: UNSort,
                           completion: @escaping UNPhotoListClosure)
    {
        if self.hasCredentials
        {
            let parameters = UNPhotoListParameters(pageNumber: page,
                                                   photosPerPage: photosPerPage,
                                                   sortOrder: sort)
            
            self.queryManager?.listPhotos(with: parameters,
                                          completion: completion)
        }
        else
        {
            self.printMissingCredentialsWarning()
            completion(UNResult.failure(UNError(reason: .credentialsNotSet)))
        }
    }
    
    
    // MARK: - Search
    
    /// Get a single page of photo results for a query.
    ///
    /// - Parameters:
    ///   - query: Search terms.
    ///   - page: Page number to retrieve.
    ///   - photosPerPage: Number of items per page.
    ///   - collections: Collection ID(‘s) to narrow search.
    ///   - orientation: Filter search results by photo orientation.
    ///   - completion: The completion handler that will be called with the results (Executed on the main thread).
    public func searchPhotos(query: String,
                             page: Int,
                             photosPerPage: Int,
                             collections: [UNCollection]? = nil,
                             orientation: UNPhotoOrientation? = nil,
                             completion: @escaping UNPhotoSearchClosure)
    {
        let parameters = UNPhotoSearchParameters(query: query,
                                                 pageNumber: page,
                                                 photosPerPage: photosPerPage,
                                                 collections: collections,
                                                 orientation: orientation)
        
        self.search(.photo,
                    with: parameters,
                    completion: completion)
    }
    
    
    /// Get a single page of collections results for a query.
    ///
    /// - Parameters:
    ///   - query: Search terms.
    ///   - page: Page number to retrieve.
    ///   - collectionsPerPage: Number of items per page.
    ///   - completion: The completion handler that will be called with the results (Executed on the main thread).
    public func searchCollections(query: String,
                                  page: Int,
                                  collectionsPerPage: Int,
                                  completion: @escaping UNCollectionSearchClosure)
    {
        let parameters = UNCollectionSearchParameters(query: query,
                                                      pageNumber: page,
                                                      collectionsPerPage: collectionsPerPage)
        self.search(.collection,
                    with: parameters,
                    completion: completion)
    }
    
    
    /// Get a single page of users results for a query.
    ///
    /// - Parameters:
    ///   - query: Search terms.
    ///   - page: Page number to retrieve.
    ///   - usersPerPage: Number of items per page.
    ///   - completion: The completion handler that will be called with the results (Executed on the main thread).
    public func searchUsers(query: String,
                            page: Int,
                            usersPerPage: Int,
                            completion: @escaping UNUserSearchClosure)
    {
        let parameters = UNUserSearchParameters(query: query,
                                                pageNumber: page,
                                                usersPerPage: usersPerPage)
        
        self.search(.user,
                    with: parameters,
                    completion: completion)
    }
    
    
    /// Makes a search according to the specified parameters.
    ///
    /// - Parameters:
    ///   - searchType: The type of search to perform.
    ///   - parameters: Parameters to filter the search.
    ///   - completion: The completion handler that will be called with the results (Executed on the main thread).
    internal func search<T>(_ searchType: SearchType,
                            with parameters: ParametersURLRepresentable,
                            completion: @escaping (UNResult<UNSearchResult<T>>) -> Void)
    {
        if self.hasCredentials
        {
            self.queryManager?.search(searchType,
                                      with: parameters,
                                      completion: completion)
        }
        else
        {
            self.printMissingCredentialsWarning()
            completion(UNResult.failure(UNError(reason: .credentialsNotSet)))
        }
    }
    
    
    // MARK: - Fetching images from photos
    
    #if os(iOS) || os(tvOS) || os(watchOS)
    
    /// Fetches the image corresponding to the photo on the specified size.
    ///
    /// - Parameters:
    ///   - photo: The photo to download the image from.
    ///   - size: One of the available sizes for the image to be downloaded.
    ///   - completion: The completion closure to handle the result. It will be called on the main thread.
    public func fetchImage(from photo: UNPhoto,
                           inSize size: UNPhotoImageSize,
                           completion: @escaping UNImageFetchClosure)
    {
        self.fetchDataImage(from: photo, inSize: size)
        { (requestedPhoto, requestedSize, dataImage, error) in
            
            if let error = error
            {
                completion(.failure(error))
            }
            else if let dataImage = dataImage,
                    let image = UIImage(data: dataImage)
            {
                let imageResult = UNImageFetchResult(requestedPhoto: requestedPhoto,
                                                     requestedSize: requestedSize,
                                                     image: image)
                completion(.success(imageResult))
            }
            else
            {
                completion(.failure(UNError(reason: .unableToParseDataCorrectly)))
            }
        }
    }
    
    #endif
    
    
    /// Fetches the image corresponding to the photo on the specified size.
    ///
    /// - Parameters:
    ///   - photo: The photo to download the image from.
    ///   - size: One of the available sizes for the image to be downloaded.
    ///   - completion: The completion closure to handle the result. The image will be passed as a Data.
    ///                 It will be called on the main thread.
    public func fetchDataImage(from photo: UNPhoto,
                               inSize size: UNPhotoImageSize,
                               completion: @escaping UNFetchDataImageClosure)
    {
        if self.hasCredentials
        {
            self.imagesManager?.dataImage(from: photo,
                                          inSize: size,
                                          completion: completion)
        }
        else
        {
            self.printMissingCredentialsWarning()
            completion(photo, size, nil, UNError(reason: .credentialsNotSet))
        }
    }
    
    
    /// The image will be fetched and passed back to the specified requester. This function is exclusive
    /// since the requester will only have one active request at a time. Any new request by the same object
    /// will cancel the previous one. This is useful for table views or collection views where the cell
    /// may be reuse for another photo before the previous requested image is dowloaded.
    ///
    /// - Parameters:
    ///   - photo: The photo that corresponds to the desired image.
    ///   - size: The size of the image to be downloaded.
    ///   - requester: The object that is interested in the image and the one who will be called back.
    public func fetchDataImageExclusively(from photo: UNPhoto,
                                          inSize size: UNPhotoImageSize,
                                          for requester: UNImageRequester)
    {
        if self.hasCredentials
        {
            self.imagesManager?.dataImageExclusivelyRequest(from: photo,
                                                            inSize: size,
                                                            for: requester)
        }
        else
        {
            self.printMissingCredentialsWarning()
            requester.clientDidCompleteExclusiveImageRequest(for: photo,
                                                             in: size,
                                                             dataImage: nil,
                                                             error: UNError(reason: .credentialsNotSet))
        }
    }
    
    
    // MARK: - Helpers
    
    /// Console warning reminding that the credentials were not yet set.
    internal func printMissingCredentialsWarning()
    {
        print("✋ UNClient: AppID and Secret are not set. Please do this before calling any else.")
    }
}
