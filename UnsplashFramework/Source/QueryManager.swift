//
//  QueryManager.swift
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


class QueryManager
{
    
    // MARK: - Properties
    
    /// Unsplash client credentials.
    private let credentials : UNCredentials
    
    /// Session used for querying Unsplash.
    private let session = URLSession(configuration: .default)
    
    
    /// Creates a client with the specified credentials.
    ///
    /// - Parameters:
    ///   - credentials: The Unsplash client credentials.
    public init(withCredentials credentials: UNCredentials)
    {
        self.credentials = credentials
    }
    
    
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
                           completion: @escaping UNPhotoQueryClosure)
    {
        let parameters = PhotoListParameters(pageNumber: page,
                                             photosPerPage: photosPerPage,
                                             sortOrder: sort)
        let request = URLRequest.publicRequest(.get,
                                               forEndpoint: .photos,
                                               parameters: parameters,
                                               credentials: self.credentials)
        
        let task = self.session.dataTask(with: request)
        { (data, response, requestError) in
            
            self.processListingPhotosResponse(data: data,
                                              response: response,
                                              requestError: requestError,
                                              completion: completion)
        }
        
        task.resume()
    }
    
    
    /// Parses the server's response.
    ///
    /// - Parameters:
    ///   - data: data received from the server.
    ///   - response: response received from the server.
    ///   - requestError: connection error if there was one.
    ///   - completion: closure called with the data parsed or error if there was one.
    internal func processListingPhotosResponse(data: Data?,
                                               response: URLResponse?,
                                               requestError: Error?,
                                               completion: @escaping UNPhotoQueryClosure)
    {
        var photos = [UNPhoto]()
        var error  : UNError? = nil
        
        if let unError = UNError.checkIfItIsAnError(response, and: requestError)
        {
            error = unError
        }
        else if let data = data,
            let decodedPhotos = try? JSONDecoder().decode([UNPhoto].self, from: data)
        {
            photos = decodedPhotos
        }
        else
        {
            error = UNError(reason: .unableToParseDataCorrectly)
        }
        
        DispatchQueue.main.async { completion(photos, error) }
    }
}
