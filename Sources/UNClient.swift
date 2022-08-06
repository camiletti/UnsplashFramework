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

/// The UNClient is the point of access to every Unsplash request.
public final class UNClient {

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
    public func editorialPhotosList(page: Int,
                                    photosPerPage: Int = 10,
                                    sortingBy sort: UNSort) async throws -> [UNPhoto] {
        let parameters = UNPhotoListParameters(pageNumber: page,
                                               photosPerPage: photosPerPage,
                                               sortOrder: sort)

        return try await queryManager.editorialPhotosList(with: parameters)
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
    public func searchPhotos(query: String,
                             page: Int,
                             photosPerPage: Int,
                             collections: [UNCollection]? = nil,
                             orientation: UNPhotoOrientation? = nil) async throws -> UNSearchResult<UNPhoto> {
        let parameters = UNPhotoSearchParameters(query: query,
                                                 pageNumber: page,
                                                 photosPerPage: photosPerPage,
                                                 collections: collections,
                                                 orientation: orientation)

        return try await search(.photo,
                                with: parameters)
    }

    /// Get a single page of collections results for a query.
    ///
    /// - Parameters:
    ///   - query: Search terms.
    ///   - page: Page number to retrieve.
    ///   - collectionsPerPage: Number of items per page.
    public func searchCollections(query: String,
                                  page: Int,
                                  collectionsPerPage: Int) async throws-> UNSearchResult<UNCollection> {
        let parameters = UNCollectionSearchParameters(query: query,
                                                      pageNumber: page,
                                                      collectionsPerPage: collectionsPerPage)
        return try await search(.collection,
                                with: parameters)
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
                            usersPerPage: Int) async throws -> UNSearchResult<UNUser> {
        let parameters = UNUserSearchParameters(query: query,
                                                pageNumber: page,
                                                usersPerPage: usersPerPage)

        return try await search(.user,
                                with: parameters)
    }

    /// Makes a search according to the specified parameters.
    ///
    /// - Parameters:
    ///   - searchType: The type of search to perform.
    ///   - parameters: Parameters to filter the search.
    ///   - completion: The completion handler that will be called with the results (Executed on the main thread).
    func search<T>(_ searchType: SearchType,
                   with parameters: ParametersURLRepresentable) async throws -> UNSearchResult<T> {
        try await queryManager.search(searchType,
                                      with: parameters)
    }
}
