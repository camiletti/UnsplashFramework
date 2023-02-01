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

    /// Total number of requests per hour allowed for the Access Key in use
    ///
    /// The value will be nil until the first request is done
    public private(set) var requestsLimit: Int?

    /// Numbero of requests left for the current hour interval for the Access Key in use
    ///
    /// The value will be nil until the first request is done
    public private(set) var requestsRemaining: Int?

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
        let response = try await queryManager.publicProfile(with: parameters)
        return extractValueProcessingHeaders(from: response)
    }

    /// Retrieve a single user’s portfolio link (if set).
    /// - Parameter username: The user’s username.
    /// - Returns: The URL the user has set as they portfolio (if any).
    public func portfolioLink(forUsername username: String) async throws -> URL? {
        let parameters = UNUserPublicProfileParameters(username: username)
        let response = try await queryManager.portfolioLink(with: parameters)
        return extractValueProcessingHeaders(from: response).url
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
        let response = try await queryManager.userPhotos(with: parameters)
        return extractValueProcessingHeaders(from: response)
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
        let response = try await queryManager.userLikedPhotos(with: parameters)
        return extractValueProcessingHeaders(from: response)
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
        let response = try await queryManager.collections(with: parameters)
        return extractValueProcessingHeaders(from: response)
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
        let parameters = UNStatisticsParameters(interval: interval,
                                                quantity: quantity)
        let response = try await queryManager.userStatistics(forUsername: username, with: parameters)
        return extractValueProcessingHeaders(from: response)
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

        let response = try await queryManager.editorialPhotosList(with: parameters)
        return extractValueProcessingHeaders(from: response)
    }

    /// Retrieve a single photo.
    /// - Parameter id: The photo’s ID.
    /// - Returns: A single photo by the given ID.
    public func photo(withID id: String) async throws -> UNFullPhoto {
        let response = try await queryManager.photo(withID: id)
        return extractValueProcessingHeaders(from: response)
    }

    /// Retrieve random photos, given optional filters.
    ///
    /// - Parameters:
    ///   - collectionIDs: Public collection ID(‘s) to filter selection.
    ///   - topicIDs: Public topic ID(‘s) to filter selection.
    ///   - username: Limit selection to a single user.
    ///   - orientationFilter: Filter by photo orientation.
    ///   - contentFilter: Limit results by content safety.
    ///   - amountOfRandomPhotos: The number of photos to return. (max: 30)
    ///   - Returns: An array of random photos.
    public func randomPhotos(fromCollectionWithIDs collectionIDs: [String] = [],
                             ofTopicWithIDs topicIDs: [String] = [],
                             fromUsername username: String? = nil,
                             oriented orientationFilter: UNPhotoOrientation? = nil,
                             safetyLevel contentFilter: UNContentSafetyFilter? = nil,
                             returningAmount amountOfRandomPhotos: Int = 1) async throws -> [UNFullPhoto] {
        let parameters = UNRandomPhotoParameters(collectionIDs: collectionIDs,
                                                 topicIDs: topicIDs,
                                                 username: username,
                                                 searchQuery: nil,
                                                 orientationFilter: orientationFilter,
                                                 contentFilter: contentFilter,
                                                 amountOfRandomPhotos: amountOfRandomPhotos)
        let response = try await queryManager.randomPhotos(with: parameters)
        return extractValueProcessingHeaders(from: response)
    }

    /// Retrieve a single random photos, given optional filters.
    ///
    /// - Parameters:
    ///   - searchQuery: Limit selection to photos matching a search term.
    ///   - username: Limit selection to a single user.
    ///   - orientationFilter: Filter by photo orientation.
    ///   - contentFilter: Limit results by content safety.
    ///   - amountOfRandomPhotos: The number of photos to return. (max: 30)
    ///   - Returns: An array of random photos.
    public func randomPhotos(usingQuery searchQuery: String? = nil,
                             fromUsername username: String? = nil,
                             oriented orientationFilter: UNPhotoOrientation? = nil,
                             safetyLevel contentFilter: UNContentSafetyFilter? = nil,
                             returningAmount amountOfRandomPhotos: Int = 1) async throws -> [UNFullPhoto] {
        let parameters = UNRandomPhotoParameters(collectionIDs: [],
                                                 topicIDs: [],
                                                 username: username,
                                                 searchQuery: searchQuery,
                                                 orientationFilter: orientationFilter,
                                                 contentFilter: contentFilter,
                                                 amountOfRandomPhotos: amountOfRandomPhotos)
        let response = try await queryManager.randomPhotos(with: parameters)
        return extractValueProcessingHeaders(from: response)
    }

    /// Retrieve total number of downloads, views and likes of a
    /// single photo, as well as the historical breakdown of these
    ///  stats in a specific timeframe (default is 30 days).
    ///
    /// - Parameters:
    ///   - photoID: The photo’s ID.
    ///   - interval: The frequency of the stats.
    ///   - quantity: The amount of for each stat, between 1 and 30.
    /// - Returns: The user's statistic entity.
    public func statistics(forPhotoWithID photoID: String,
                           interval: UNStatisticsInterval = .days,
                           quantity: Int = 30) async throws -> UNPhotoStatistics {
        let parameters = UNStatisticsParameters(interval: interval,
                                                quantity: quantity)
        let response = try await queryManager.userStatistics(forPhotoWithID: photoID, with: parameters)
        return extractValueProcessingHeaders(from: response)
    }

    /// To abide by the API guidelines, you need call this function
    /// every time your application performs a download of a photo.
    /// To understand what constitutes a download, please refer to
    /// the ‘Triggering a download’ guideline from Unsplash.
    ///
    /// Note: This is different than the concept of a view, which is
    /// tracked automatically when you `hotlink` an image.
    ///
    /// - Parameter photoID: The ID of the photo to track.
    /// - Returns: The download URL for the photo.
    public func trackPhotoDownloaded(withID photoID: String) async throws -> URL? {
        let response = try await queryManager.trackPhotoDownloaded(withID: photoID)
        return extractValueProcessingHeaders(from: response).url
    }

    /// Update a photo on behalf of the logged-in user. This requires the `write_photos` scope.
    ///
    /// - Parameters:
    ///   - photoID: The ID of the photo to update.
    ///   - changingDescription: The new description.
    ///   - showsOnProfile: Whether it should show on the user's profile.
    ///   - tags: The tags to set to the photo.
    ///   - location: The location information to update.
    ///   - cameraDetails: The camera details to update.
    /// - Returns: A photo object with the changes done.
    public func updatePhotoInfo(withID photoID: String,
                                changingDescription: String? = nil,
                                showsOnProfile: Bool? = nil,
                                tags: [String]? = nil,
                                location: UNLocation? = nil,
                                cameraDetails: UNCameraDetails? = nil) async throws -> UNPhoto {
        let parameters = UNUpdatePhotoInfoParameters(description: changingDescription,
                                                     showsOnProfile: showsOnProfile,
                                                     tags: tags,
                                                     location: location,
                                                     cameraDetails: cameraDetails)
        let response = try await queryManager.updatePhotoInfo(forPhotoWithID: photoID, with: parameters)
        return extractValueProcessingHeaders(from: response)
    }

    /// Like a photo on behalf of the logged-in user. This requires the write_likes scope.
    ///
    /// This action is idempotent; liking an already liked photo has no additional effect.
    ///
    /// - Parameter id: The photo’s ID.
    /// - Returns: The liked photo.
    public func likePhoto(withID id: String) async throws -> UNPhoto {
        let response = try await queryManager.likePhoto(withID: id)
        return extractValueProcessingHeaders(from: response)
    }

    /// Remove a user’s like of a photo. This requires the write_likes scope.
    ///
    /// This action is idempotent; unliking a photo that was not liked by the user has no additional effect.
    ///
    /// - Parameter id: The photo’s ID.
    /// - Returns: The unliked photo.
    public func unlikePhoto(withID id: String) async throws -> UNPhoto {
        let response = try await queryManager.unlikePhoto(withID: id)
        return extractValueProcessingHeaders(from: response)
    }

    // MARK: - Search

    /// Get a single page of photo results for a query.
    ///
    /// - Parameters:
    ///   - query: Search terms.
    ///   - pageNumber: Page number to retrieve.
    ///   - photosPerPage: Number of items per page.
    ///   - order: How to sort the photos.
    ///   - collectionIDS: Collection ID(‘s) to narrow search.
    ///   - safetyLevel: Limit results by content safety.
    ///   - colorScheme: Filter results by color.
    ///   - orientation: Filter search results by photo orientation.
    /// - Returns: The search result containing the photos that met the specified criteria.
    public func searchPhotos(query: String,
                             pageNumber: Int = 1,
                             photosPerPage: Int = 10,
                             orderedBy order: UNOrder = .relevance,
                             containedInCollectionsWithIDs collectionIDS: [String] = [],
                             safetyLevel: UNContentSafetyFilter? = .low,
                             colorScheme: UNPhotoColorScheme? = nil,
                             orientation: UNPhotoOrientation? = nil) async throws -> UNSearchResult<UNPhoto> {
        let parameters = UNPhotoSearchParameters(query: query,
                                                 pageNumber: pageNumber,
                                                 photosPerPage: photosPerPage,
                                                 order: order,
                                                 collectionsIDs: collectionIDS,
                                                 safetyLevel: safetyLevel,
                                                 colorScheme: colorScheme,
                                                 orientation: orientation)

        let response: (UNSearchResult<UNPhoto>, [ResponseHeader]) = try await queryManager.search(.photo,
                                                                                                  with: parameters)
        return extractValueProcessingHeaders(from: response)
    }

    /// Get a single page of collection results for a query.
    ///
    /// - Parameters:
    ///   - query: Search terms.
    ///   - page: Page number to retrieve.
    ///   - collectionsPerPage: Number of items per page.
    public func searchCollections(query: String,
                                  page: Int = 1,
                                  collectionsPerPage: Int = 10) async throws-> UNSearchResult<UNCollection> {
        let parameters = UNCollectionSearchParameters(query: query,
                                                      pageNumber: page,
                                                      collectionsPerPage: collectionsPerPage)
        let response: (UNSearchResult<UNCollection>, [ResponseHeader]) = try await queryManager.search(.collection,
                                                                                                       with: parameters)
        return extractValueProcessingHeaders(from: response)
    }

    /// Get a single page of users results for a query.
    ///
    /// - Parameters:
    ///   - query: Search terms.
    ///   - page: Page number to retrieve.
    ///   - usersPerPage: Number of items per page.
    ///   - completion: The completion handler that will be called with the results (Executed on the main thread).
    public func searchUsers(query: String,
                            page: Int = 1,
                            usersPerPage: Int = 10) async throws -> UNSearchResult<UNUser> {
        let parameters = UNUserSearchParameters(query: query,
                                                pageNumber: page,
                                                usersPerPage: usersPerPage)

        let response: (UNSearchResult<UNUser>, [ResponseHeader]) = try await queryManager.search(.user,
                                                                                                 with: parameters)
        return extractValueProcessingHeaders(from: response)
    }

    // MARK: - Collections

    /// Get a single page from the list of all collections.
    /// - Parameters:
    ///   - pageNumber: Page number to retrieve.
    ///   - collectionsPerPage: Number of items per page.
    /// - Returns: Array with collections
    public func collectionList(pageNumber: Int = 1,
                               collectionsPerPage: Int = 10) async throws -> [UNCollection] {
        let parameters = UNCollectionListParameters(pageNumber: pageNumber,
                                                    collectionsPerPage: collectionsPerPage)

        let response = try await queryManager.collectionList(parameters: parameters)
        return extractValueProcessingHeaders(from: response)
    }

    /// Retrieve a single collection. To view a user’s private collections, the `read_collections` scope is required.
    /// - Parameter id: The collections’s ID.
    /// - Returns: A single collection
    public func collection(withID id: String) async throws -> UNCollection {
        let response = try await queryManager.collection(withID: id)
        return extractValueProcessingHeaders(from: response)
    }

    /// Retrieve a collection’s photos.
    /// - Parameters:
    ///   - collectionID: The collection’s ID.
    ///   - page: Page number to retrieve.
    ///   - photosPerPage: Number of items per page.
    ///   - orientation: Filter by photo orientation.
    /// - Returns: A collection’s photos.
    public func photosInCollection(withID collectionID: String,
                                   page: Int = 1,
                                   photosPerPage: Int = 10,
                                   orientation: UNPhotoOrientation? = nil) async throws -> [UNPhoto] {
        let parameters = UNCollectionPhotosParameters(pageNumber: page,
                                                      photosPerPage: photosPerPage,
                                                      orientation: orientation)

        let response = try await queryManager.photosInCollection(withID: collectionID, parameters: parameters)
        return extractValueProcessingHeaders(from: response)
    }

    /// Retrieve a list of collections related to this one.
    /// - Parameter collectionID: The collection’s ID.
    /// - Returns: A list of collections related to this one.
    public func relatedCollections(toCollectionWithID collectionID: String) async throws -> [UNCollection] {
        let response = try await queryManager.relatedCollections(toCollectionWithID: collectionID)
        return extractValueProcessingHeaders(from: response)
    }

    /// Create a new collection. This requires the `write_collections` scope.
    /// - Parameters:
    ///   - title: The title of the collection.
    ///   - description: The collection’s description.
    ///   - isPrivate: Whether to make this collection private.
    /// - Returns: Responds with the new collection.
    @discardableResult
    public func createNewCollection(title: String,
                                    description: String? = nil,
                                    isPrivate: Bool = false) async throws -> UNCollection {
        let parameters = UNNewCollectionParameters(title: title, description: description, isPrivate: isPrivate)

        let response = try await queryManager.createNewCollection(parameters: parameters)
        return extractValueProcessingHeaders(from: response)
    }

    /// Update an existing collection belonging to the logged-in user. This requires the `write_collections` scope.
    /// - Parameters:
    ///   - collectionID: The collection’s ID.
    ///   - title: The title of the collection.
    ///   - description: The collection’s description.
    ///   - isPrivate: Whether to make this collection private.
    /// - Returns: Responds with the updated collection.
    @discardableResult
    public func updateCollection(withID collectionID: String,
                                 title: String? = nil,
                                 description: String? = nil,
                                 isPrivate: Bool? = nil) async throws -> UNCollection {
        let parameters = UNUpdateCollectionParameters(title: title, description: description, isPrivate: isPrivate)

        let response = try await queryManager.updateCollection(withID: collectionID,  parameters: parameters)
        return extractValueProcessingHeaders(from: response)
    }

    /// Delete a collection belonging to the logged-in user. This requires the `write_collections` scope.
    /// - Parameters:
    ///   - collectionID: The collection’s ID.
    public func deleteCollection(withID collectionID: String) async throws {
        let headers = try await queryManager.deleteCollection(withID: collectionID)
        processHeaders(headers)
    }

    /// Add a photo to one of the logged-in user’s collections. Requires the `write_collections` scope.
    ///
    /// Note: If the photo is already in the collection, this action has no effect.
    ///
    /// - Parameters:
    ///   - photoID: The collection’s ID.
    ///   - collectionID: The photo’s ID.
    /// - Returns: The photo that was added and the collection.
    @discardableResult
    public func addPhoto(withID photoID: String, toCollectionWithID collectionID: String) async throws -> (UNPhoto, UNCollection) {
        let parameters = UNModifyPhotoToCollectionParameters(photoID: photoID)

        let response = try await queryManager.addPhotoToCollection(withID: collectionID,
                                                                   parameters: parameters)
        let value = extractValueProcessingHeaders(from: response)
        return (value.photo, value.collection)
    }

    /// Remove a photo to one of the logged-in user’s collections. Requires the `write_collections` scope.
    /// - Parameters:
    ///   - photoID: The collection’s ID.
    ///   - collectionID: The photo’s ID.
    /// - Returns: The photo that was removed and its collection.
    @discardableResult
    public func removePhoto(withID photoID: String, fromCollectionWithID collectionID: String) async throws -> (UNPhoto, UNCollection) {
        let parameters = UNModifyPhotoToCollectionParameters(photoID: photoID)

        let response = try await queryManager.removePhotoFromCollection(withID: collectionID,
                                                                        parameters: parameters)

        let value = extractValueProcessingHeaders(from: response)
        return (value.photo, value.collection)
    }

    // MARK: - Topics

    /// Get a single page from the list of all topics.
    /// - Parameters:
    ///   - idsOrSlugs: Limit to only matching topic ids or slugs
    ///   - pageNumber: Page number to retrieve.
    ///   - topicsPerPage: Number of items per page.
    ///   - sortOrder: How to sort the topics.
    /// - Returns: A single page from the list of all topics.
    public func topicList(idsOrSlugs: [String]?,
                          pageNumber: Int = 1,
                          topicsPerPage: Int = 10,
                          sortingBy sortOrder: UNTopicSort = .position) async throws -> [UNTopic] {
        let parameters = UNTopicListParameters(idsOrSlugs: idsOrSlugs,
                                               pageNumber: pageNumber,
                                               topicsPerPage: topicsPerPage,
                                               sorting: sortOrder)

        let response = try await queryManager.topicList(parameters: parameters)
        return extractValueProcessingHeaders(from: response)
    }

    /// Get a topic
    /// - Parameter idOrSlug: The topics’s ID or slug.
    /// - Returns: A single topic
    public func topic(withIDOrSlug idOrSlug: String) async throws -> UNTopic {
        let response = try await queryManager.topic(withIDOrSlug: idOrSlug)
        return extractValueProcessingHeaders(from: response)
    }

    /// Retrieve a topic’s photos.
    /// - Parameters:
    ///   - idOrSlug: The topics’s ID or slug.
    ///   - pageNumber: Page number to retrieve.
    ///   - photosPerPage: Number of items per page.
    ///   - orientation: Filter by photo orientation.
    ///   - sortOrder: How to sort the photos.
    /// - Returns: A topic’s photos.
    public func photosOfTopic(idOrSlug: String,
                              pageNumber: Int = 1,
                              photosPerPage: Int = 10,
                              orientation: UNPhotoOrientation? = nil,
                              sortingBy sortOrder: UNSort = .latest) async throws -> [UNPhoto] {
        let parameters = UNTopicPhotosParameters(pageNumber: pageNumber,
                                                 photosPerPage: photosPerPage,
                                                 orientation: orientation,
                                                 order: sortOrder)

        let response = try await queryManager.photosOfTopic(idOrSlug: idOrSlug, parameters: parameters)
        return extractValueProcessingHeaders(from: response)
    }

    // MARK: - Stats

    /// Get a list of counts for all of Unsplash.
    public func unsplashTotalStats() async throws -> UNUnsplashTotalStats {
        let response = try await queryManager.unsplashTotalStats()
        return extractValueProcessingHeaders(from: response)
    }

    /// Get the overall Unsplash stats for the past 30 days.
    public func unsplashMonthlyStats() async throws -> UNUnsplashMonthlyStats {
        let response = try await queryManager.unsplashMonthlyStats()
        return extractValueProcessingHeaders(from: response)
    }

    // MARK: - Authorization

    /// Creates an authorization URL. This URL should be opened in a web browser so the user can grant the
    /// requested permissions via Unsplash login. Once the user completes the authorization, Unsplash will call the redirect URI specified on the credentials.
    /// `handleAuthorizationCallback(url:)` should be called when this happens in order to process the result and obtain upgraded
    /// credentials with the requested scope.
    /// - Parameters:
    ///   - scope: A set with the desired access privileges.
    /// - Returns: An authorization URL that should be opened in a web browser.
    public func authorizationURL(scope: Set<UserAuthorizationScope>) -> URL {
        queryManager.authorizationURL(scope: scope)
    }

    /// Handles the callback URL that Unsplash returned after invoking `authorizationURL(scope:)`
    /// - Parameters:
    ///   - url: The URL that Unsplash has called back with.
    public func handleAuthorizationCallback(url: URL) async throws {
        try await queryManager.handleAuthorizationCallback(url: url)
    }

    // MARK: - Helpers

    private func extractValueProcessingHeaders<T>(from response: (value: T, headers: [ResponseHeader])) -> T {
        processHeaders(response.headers)
        return response.value
    }

    private func processHeaders(_ headers: [ResponseHeader]) {
        for header in headers {
            switch header {
            case .requestsRemaining(let amount):
                self.requestsRemaining = amount

            case .requestLimit(let amount):
                self.requestsLimit = amount
            }
        }
    }
}
