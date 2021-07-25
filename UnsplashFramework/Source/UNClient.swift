//
//  UnsplashFramework.swift
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

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#endif

public typealias UNPhotoListClosure = (_ result: Result<[UNPhoto], UNError>) -> Void
public typealias UNPhotoSearchClosure = (_ result: Result<UNSearchResult<UNPhoto>, UNError>) -> Void
public typealias UNCollectionSearchClosure = (_ result: Result<UNSearchResult<UNCollection>, UNError>) -> Void
public typealias UNUserSearchClosure = (_ result: Result<UNSearchResult<UNUser>, UNError>) -> Void

/// The UNClient is the point of access to every Unsplash request.
public class UNClient {

    // MARK: - Properties

    private let queryManager: QueryManager

    // MARK: - Life Cycle

    public init(with credentials: UNCredentials) {
        let api = UNAPI(credentials: credentials)
        self.queryManager = QueryManager(api: api)
    }

    init(queryManager: QueryManager) {
        self.queryManager = queryManager
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
                           completion: @escaping UNPhotoListClosure) {
        let parameters = UNPhotoListParameters(pageNumber: page,
                                               photosPerPage: photosPerPage,
                                               sortOrder: sort)

        queryManager.listPhotos(with: parameters,
                                completion: completion)
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
                             completion: @escaping UNPhotoSearchClosure) {
        let parameters = UNPhotoSearchParameters(query: query,
                                                 pageNumber: page,
                                                 photosPerPage: photosPerPage,
                                                 collections: collections,
                                                 orientation: orientation)

        search(.photo,
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
                                  completion: @escaping UNCollectionSearchClosure) {
        let parameters = UNCollectionSearchParameters(query: query,
                                                      pageNumber: page,
                                                      collectionsPerPage: collectionsPerPage)
        search(.collection,
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
                            completion: @escaping UNUserSearchClosure) {
        let parameters = UNUserSearchParameters(query: query,
                                                pageNumber: page,
                                                usersPerPage: usersPerPage)

        search(.user,
               with: parameters,
               completion: completion)
    }

    /// Makes a search according to the specified parameters.
    ///
    /// - Parameters:
    ///   - searchType: The type of search to perform.
    ///   - parameters: Parameters to filter the search.
    ///   - completion: The completion handler that will be called with the results (Executed on the main thread).
    func search<T>(_ searchType: SearchType,
                   with parameters: ParametersURLRepresentable,
                   completion: @escaping (Result<UNSearchResult<T>, UNError>) -> Void) {
        queryManager.search(searchType,
                            with: parameters,
                            completion: completion)
    }

    // MARK: - Helpers

    /// Console warning reminding that the credentials were not yet set.
    private func printMissingCredentialsWarning() {
        print("✋ UNClient: AppID and Secret are not set. Please do this before calling any else.")
    }
}
