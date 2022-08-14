//
//  UnsplashFramework
//
//  Copyright Pablo Camiletti
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

    // MARK: - Users

    /// Retrieve public details on a given user.
    /// - Parameter username: The user’s username.
    /// - Returns: An entity representing all the public information of the user's profile
    public func publicProfile(forUsername username: String) async throws -> UNUserPublicProfile {
        let parameters = UNUserPublicProfileParameters(username: username)
        return try await queryManager.publicProfile(with: parameters)
    }

    /// Retrieve a single user’s portfolio link (if set).
    /// - Parameter username: The user’s username.
    /// - Returns: The URL the user has set as they portfolio (if any).
    public func portfolioLink(forUsername username: String) async throws -> URL? {
        let parameters = UNUserPublicProfileParameters(username: username)
        let urlWrapper = try await queryManager.portfolioLink(with: parameters)
        return urlWrapper.url
    }

    /// Get a list of photos uploaded by a user.
    /// - Parameters:
    ///   - username: The user’s username.
    ///   - pageNumber: Page number to retrieve.
    ///   - photosPerPage: Number of items per page.
    ///   - sorting: How to sort the photos.
    ///   - includeStats: Show the stats for each user’s photo.
    ///   - statsInterval: The frequency of the stats.
    ///   - statsAmount: The amount of for each stat.
    ///   - orientationFilter: Filter by photo orientation.
    /// - Returns: An array with the photos of the user in a given page.
    public func photos(fromUsername username: String,
                       pageNumber: Int = 1,
                       photosPerPage: Int = 10,
                       sortingBy sortOrder: UNSort = .latest,
                       includeStats: Bool = false,
                       statsInterval: UNStatisticsInterval = .days,
                       statsAmount: Int? = nil,
                       orientationFilter: UNPhotoOrientation? = nil) async throws -> [UNPhoto] {
        let parameters = UNUserPhotosParameters(username: username,
                                                pageNumber: pageNumber,
                                                photosPerPage: photosPerPage,
                                                sorting: sortOrder,
                                                includeStats: includeStats,
                                                statsInterval: statsInterval,
                                                statsAmount: statsAmount,
                                                orientationFilter: orientationFilter)
        return try await queryManager.userPhotos(with: parameters)
    }

    /// Get a list of photos liked by a user.
    /// - Parameters:
    ///   - username: The user’s username.
    ///   - pageNumber: Page number to retrieve.
    ///   - photosPerPage: Number of items per page.
    ///   - sorting: How to sort the photos.
    ///   - orientationFilter: Filter by photo orientation.
    /// - Returns: An array with the photos the user has liked in a given page.
    public func photosLiked(byUsername username: String,
                            pageNumber: Int = 1,
                            photosPerPage: Int = 10,
                            sortingBy sortOrder: UNSort = .latest,
                            orientationFilter: UNPhotoOrientation? = nil) async throws -> [UNPhoto] {
        let parameters = UNUserLikesParameters(username: username,
                                               pageNumber: pageNumber,
                                               photosPerPage: photosPerPage,
                                               sorting: sortOrder,
                                               orientationFilter: orientationFilter)
        return try await queryManager.userLikedPhotos(with: parameters)
    }

    /// Get a list of collections created by the user.
    ///
    /// - Parameters:
    ///   - username: The user’s username.
    ///   - pageNumber: Page number to retrieve.
    ///   - collectionsPerPage: Number of items per page.
    /// - Returns: An array with the user's collections in a given page.
    public func collections(byUsername username: String,
                            pageNumber: Int = 1,
                            collectionsPerPage: Int = 10) async throws -> [UNCollection] {
        let parameters = UNUserCollectionsParameters(username: username,
                                                     pageNumber: pageNumber,
                                                     collectionsPerPage: collectionsPerPage)
        return try await queryManager.collections(with: parameters)
    }

    /// Retrieve the consolidated number of downloads, views and likes of all user’s
    /// photos, as well as the historical breakdown and average of these stats in a
    /// specific timeframe (default is 30 days).
    ///
    /// - Parameters:
    ///   - username: The user’s username.
    ///   - interval: The frequency of the stats.
    ///   - quantity: The amount of for each stat, between 1 and 30.
    /// - Returns: The user's statistic entity.
    public func statistics(forUsername username: String,
                           interval: UNStatisticsInterval = .days,
                           quantity: Int = 30) async throws -> UNUserStatistics {
        let parameters = UNUserStatisticsParameters(username: username,
                                                    interval: interval,
                                                    quantity: quantity)
        return try await queryManager.userStatistics(with: parameters)
    }

    // MARK: - Listing photos

    /// Get a single page from the list of all photos.
    ///
    /// - Parameters:
    ///   - pageNumber: Page number to retrieve.
    ///   - photosPerPage: Number of items per page.
    ///   - sortOrder: How to sort the photos.
    /// - Returns: A single page from the list of all editorial photos.
    public func editorialPhotosList(pageNumber: Int,
                                    photosPerPage: Int = 10,
                                    sortingBy sortOrder: UNSort) async throws -> [UNPhoto] {
        let parameters = UNPhotoListParameters(pageNumber: pageNumber,
                                               photosPerPage: photosPerPage,
                                               sorting: sortOrder)

        return try await queryManager.editorialPhotosList(with: parameters)
    }

    /// Retrieve a single photo.
    /// - Parameter id: The photo’s ID.
    /// - Returns: A single photo by the given ID.
    public func photo(withID id: String) async throws -> UNFullPhoto {
        try await queryManager.photo(withID: id)
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
