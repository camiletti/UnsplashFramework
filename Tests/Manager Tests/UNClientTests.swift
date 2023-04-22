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
@testable import UnsplashFramework
import XCTest

final class UNClientTests: XCTestCase {

    // MARK: - Declarations

    private enum Constant {
        static let requestDeadline = 0.2
        static let credentials = UNCredentials(accessKey: "123",
                                               secret: "789",
                                               redirectAuthenticationURI: "unsplashframework://open/auth")
        static let requestsLimit = 50
        static let requestRemaining = 25
        static let responseHeaders = [ResponseHeader.Key.requestLimit.rawValue: "\(requestsLimit)",
                                      ResponseHeader.Key.requestsRemaining.rawValue: "\(requestRemaining)"]
    }

    // MARK: - Users

    func testPublicUserProfile() async throws {
        // The only important parameter for this test is the data that will be returned
        let username = "camiletti"
        let endpoint = Endpoint.userPublicProfile(username: username)
        let parameters = UNUserPublicProfileParameters(username: username)
        let queryManager = QueryManager.mock(data: DemoData.userPublicProfileResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let _ = try await client.publicProfile(forUsername: username)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testUserPortfolio() async throws {
        let username = "camiletti"
        let endpoint = Endpoint.userPortfolioLink(username: username)
        let parameters = UNUserPublicProfileParameters(username: username)
        let queryManager = QueryManager.mock(data: DemoData.userPortfolioResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let _ = try await client.portfolioLink(forUsername: username)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testUserPhotos() async throws {
        let parameters = UNUserPhotosParameters(username: "camiletti",
                                                pageNumber: 2,
                                                photosPerPage: 4,
                                                sorting: .downloads,
                                                includeStats: true,
                                                statsInterval: .days,
                                                statsAmount: 30,
                                                orientationFilter: .landscape)
        let endpoint = Endpoint.userPhotos(username: parameters.username)
        let queryManager = QueryManager.mock(data: DemoData.userPhotosResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let photos = try await client.photos(fromUsername: parameters.username,
                                             pageNumber: parameters.pageNumber!,
                                             photosPerPage: parameters.photosPerPage!,
                                             sortingBy: parameters.sorting!,
                                             includeStats: parameters.includeStats!,
                                             statsAmount: parameters.statsAmount!,
                                             orientationFilter: parameters.orientationFilter)

        XCTAssertFalse(photos.isEmpty)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testPhotosLikedByUser() async throws {
        let parameters = UNUserLikesParameters(username: "camiletti",
                                               pageNumber: 2,
                                               photosPerPage: 4,
                                               sorting: .downloads,
                                               orientationFilter: .landscape)
        let endpoint = Endpoint.userLikedPhotos(username: parameters.username)
        let queryManager = QueryManager.mock(data: DemoData.userLikesResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let photos = try await client.photosLiked(byUsername: parameters.username,
                                                  pageNumber: parameters.pageNumber!,
                                                  photosPerPage: parameters.photosPerPage!,
                                                  sortingBy: parameters.sorting!,
                                                  orientationFilter: parameters.orientationFilter)

        XCTAssertFalse(photos.isEmpty)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testCollectionsByUser() async throws {
        let parameters = UNUserCollectionsParameters(username: "zmachacek",
                                                     pageNumber: 2,
                                                     collectionsPerPage: 4)
        let endpoint = Endpoint.userCollections(username: parameters.username)
        let queryManager = QueryManager.mock(data: DemoData.userCollectionsResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let collections = try await client.collections(byUsername: parameters.username,
                                                       pageNumber: parameters.pageNumber!,
                                                       collectionsPerPage: parameters.collectionsPerPage!)

        XCTAssertFalse(collections.isEmpty)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testStatisticsByUser() async throws {
        let username = "camiletti"
        let parameters = UNStatisticsParameters(interval: .days,
                                                quantity: 15)
        let endpoint = Endpoint.userStatistics(username: username)
        let queryManager = QueryManager.mock(data: DemoData.userStatisticsResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let _ = try await client.statistics(forUsername: username,
                                            interval: parameters.interval!,
                                            quantity: parameters.quantity!)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    // MARK: - Photos

    func testListingEditorialPhotos() async throws {
        let endpoint = Endpoint.editorialPhotosList
        let parameters = UNPhotoListParameters(pageNumber: 2,
                                               photosPerPage: 4,
                                               sorting: .latest)
        let queryManager = QueryManager.mock(data: DemoData.standardPhotoListResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let photos = try await client.editorialPhotosList(pageNumber: parameters.pageNumber!,
                                                          photosPerPage: parameters.photosPerPage!,
                                                          sortingBy: parameters.sorting!)
        XCTAssertFalse(photos.isEmpty)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testFetchingAPhoto() async throws {
        let photoID = "123"
        let endpoint = Endpoint.photo(id: photoID)
        let queryManager = QueryManager.mock(data: DemoData.standardPhotoAResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: nil,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: nil)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let _ = try await client.photo(withID: photoID)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testFetchingRandomPhotoWithSearchQuery() async throws {
        let endpoint = Endpoint.randomPhoto
        let parameters = UNRandomPhotoParameters(collectionIDs: [],
                                                 topicIDs: [],
                                                 username: "camiletti",
                                                 searchQuery: "forest",
                                                 orientationFilter: .landscape,
                                                 contentFilter: .high,
                                                 amountOfRandomPhotos: 2)
        let queryManager = QueryManager.mock(data: DemoData.standardRandomPhotosWithQueryResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let photos = try await client.randomPhotos(usingQuery: parameters.searchQuery,
                                                   fromUsername: parameters.username,
                                                   oriented: parameters.orientationFilter,
                                                   safetyLevel: parameters.contentFilter,
                                                   returningAmount: parameters.amountOfRandomPhotos)

        XCTAssertEqual(photos.count, 2)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testFetchingRandomPhotoWithCollectionsAndTopics() async throws {
        let endpoint = Endpoint.randomPhoto
        let parameters = UNRandomPhotoParameters(collectionIDs: ["6820058"],
                                                 topicIDs: ["A", "B"],
                                                 username: "camiletti",
                                                 searchQuery: nil,
                                                 orientationFilter: .landscape,
                                                 contentFilter: .high,
                                                 amountOfRandomPhotos: 2)
        let queryManager = QueryManager.mock(data: DemoData.standardRandomPhotosWithQueryResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let photos = try await client.randomPhotos(fromCollectionWithIDs: parameters.collectionIDs,
                                                   ofTopicWithIDs: parameters.topicIDs,
                                                   fromUsername: parameters.username,
                                                   oriented: parameters.orientationFilter,
                                                   safetyLevel: parameters.contentFilter,
                                                   returningAmount: parameters.amountOfRandomPhotos)

        XCTAssertEqual(photos.count, 2)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testStatisticsOfPhoto() async throws {
        let photoID = "123"
        let parameters = UNStatisticsParameters(interval: .days,
                                                quantity: 15)
        let endpoint = Endpoint.photoStatistics(id: photoID)
        let queryManager = QueryManager.mock(data: DemoData.photoStatisticsResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let _ = try await client.statistics(forPhotoWithID: photoID,
                                            interval: parameters.interval!,
                                            quantity: parameters.quantity!)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testTrackingDownloadOfPhoto() async throws {
        let photoID = "123"
        let endpoint = Endpoint.trackPhotoDownload(id: photoID)
        let queryManager = QueryManager.mock(data: DemoData.standardTrackPhotoDownload,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: nil,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: nil)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let url = try await client.trackPhotoDownloaded(withID: photoID)

        XCTAssertNotNil(url)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testUpdatingPhotoInfo() async throws {
        let photoID = "123"
        let endpoint = Endpoint.photo(id: photoID)
        let parameters = UNUpdatePhotoInfoParameters(description: "A description",
                                                     showsOnProfile: true,
                                                     tags: ["Tag A", "Tag B"],
                                                     location: DemoData.location,
                                                     cameraDetails: DemoData.cameraDetails)
        let queryManager = QueryManager.mock(data: DemoData.standardPhotoAResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .put,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)

        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let photo = try await client.updatePhotoInfo(withID: photoID,
                                                     changingDescription: parameters.description,
                                                     showsOnProfile: parameters.showsOnProfile,
                                                     tags: parameters.tags,
                                                     location: parameters.location,
                                                     cameraDetails: parameters.cameraDetails)

        XCTAssertNotNil(photo)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testLikingAPhoto() async throws {
        let photoID = "123"
        let endpoint = Endpoint.likePhoto(id: photoID)
        let queryManager = QueryManager.mock(data: DemoData.standardPhotoAResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: nil,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .post,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: nil)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let photo = try await client.likePhoto(withID: photoID)

        XCTAssertNotNil(photo)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testUnlikingAPhoto() async throws {
        let photoID = "123"
        let endpoint = Endpoint.likePhoto(id: photoID)
        let queryManager = QueryManager.mock(data: DemoData.standardPhotoAResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: nil,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .delete,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: nil)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let photo = try await client.unlikePhoto(withID: photoID)

        XCTAssertNotNil(photo)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    // MARK: - Search

    func testSearchPhotos() async throws {
        let endpoint = SearchType.photo.endpoint
        let parameters = UNPhotoSearchParameters(query: "camiletti",
                                                 pageNumber: 2,
                                                 photosPerPage: 4,
                                                 order: .latest,
                                                 collectionsIDs: [],
                                                 safetyLevel: .high,
                                                 colorScheme: .blackAndWhite,
                                                 orientation: .landscape)
        let queryManager = QueryManager.mock(data: DemoData.standardPhotoSearchResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let photosSearchResult = try await client.searchPhotos(query: parameters.query,
                                                               pageNumber: parameters.pageNumber!,
                                                               photosPerPage: parameters.photosPerPage!,
                                                               orderedBy: parameters.order!,
                                                               containedInCollectionsWithIDs: parameters.collectionsIDs,
                                                               safetyLevel: parameters.safetyLevel!,
                                                               colorScheme: parameters.colorScheme!,
                                                               orientation: parameters.orientation!)

        XCTAssertFalse(photosSearchResult.elements.isEmpty)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testSearchCollection() async throws {
        let endpoint = SearchType.collection.endpoint
        let parameters = UNCollectionSearchParameters(query: "camiletti",
                                                      pageNumber: 2,
                                                      collectionsPerPage: 4)
        let queryManager = QueryManager.mock(data: DemoData.standardCollectionSearchResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: nil,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let collectionsSearchResult = try await client.searchCollections(query: parameters.query,
                                                                         page: parameters.pageNumber!,
                                                                         collectionsPerPage: parameters.collectionsPerPage!)

        XCTAssertFalse(collectionsSearchResult.elements.isEmpty)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testSearchUsers() async throws {
        let endpoint = SearchType.user.endpoint
        let parameters = UNUserSearchParameters(query: "camiletti",
                                                pageNumber: 2,
                                                usersPerPage: 4)
        let queryManager = QueryManager.mock(data: DemoData.standardUserSearchResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let usersSearchResult = try await client.searchUsers(query: parameters.query,
                                                             page: parameters.pageNumber!,
                                                             usersPerPage: parameters.usersPerPage!)

        XCTAssertFalse(usersSearchResult.elements.isEmpty)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    // MARK: - Collections

    func testListingCollections() async throws {
        let endpoint = Endpoint.collections
        let parameters = UNCollectionListParameters(pageNumber: 2,
                                                    collectionsPerPage: 4)
        let queryManager = QueryManager.mock(data: DemoData.standardCollectionListResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let collections = try await client.collectionList(pageNumber: parameters.pageNumber!,
                                                          collectionsPerPage: parameters.collectionsPerPage!)

        XCTAssertFalse(collections.isEmpty)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testFetchingACollection() async throws {
        let collectionID = "123"
        let endpoint = Endpoint.collection(id: collectionID)
        let queryManager = QueryManager.mock(data: DemoData.standardCollectionAResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: nil,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: nil)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let _ = try await client.collection(withID: collectionID)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testPhotosInCollection() async throws {
        let collectionID = "123"
        let endpoint = Endpoint.photosInCollection(id: collectionID)
        let parameters = UNCollectionPhotosParameters(pageNumber: 8,
                                                      photosPerPage: 12,
                                                      orientation: .landscape)
        let queryManager = QueryManager.mock(data: DemoData.standardPhotosInCollectionResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let photos = try await client.photosInCollection(withID: collectionID,
                                                         page: parameters.pageNumber!,
                                                         photosPerPage: parameters.photosPerPage!,
                                                         orientation: parameters.orientation!)

        XCTAssertFalse(photos.isEmpty)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testFetchingRelatedCollections() async throws {
        let collectionID = "123"
        let endpoint = Endpoint.relatedCollections(id: collectionID)
        let queryManager = QueryManager.mock(data: DemoData.standardRelatedCollectionsResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: nil,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: nil)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let collections = try await client.relatedCollections(toCollectionWithID: collectionID)

        XCTAssertFalse(collections.isEmpty)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testCreatingNewCollection() async throws {
        let endpoint = Endpoint.collections
        let parameters = UNNewCollectionParameters(title: "A Title", description: "Some description", isPrivate: true)
        let queryManager = QueryManager.mock(data: DemoData.standardCollectionAResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .post,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let _ = try await client.createNewCollection(title: parameters.title,
                                                     description: parameters.description,
                                                     isPrivate: parameters.isPrivate!)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testUpdatingCollection() async throws {
        let collectionID = "123"
        let endpoint = Endpoint.collection(id: collectionID)
        let parameters = UNUpdateCollectionParameters(title: "A Title", description: "Some description", isPrivate: true)
        let queryManager = QueryManager.mock(data: DemoData.standardCollectionAResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .put,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let _ = try await client.updateCollection(withID: collectionID,
                                                  title: parameters.title,
                                                  description: parameters.description,
                                                  isPrivate: parameters.isPrivate!)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testDeletingCollection() async throws {
        let collectionID = "123"
        let endpoint = Endpoint.collection(id: collectionID)
        let queryManager = QueryManager.mock(data: Data(),
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: nil,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .delete,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: nil)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let _ = try await client.deleteCollection(withID: collectionID)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testAddingPhotoToCollection() async throws {
        let collectionID = "123"
        let endpoint = Endpoint.addPhotoToCollection(collectionID: collectionID)
        let parameters = UNModifyPhotoToCollectionParameters(photoID: "ABC")
        let queryManager = QueryManager.mock(data: DemoData.standardAddRemoveCollectionsResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .post,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let _ = try await client.addPhoto(withID: parameters.photoID, toCollectionWithID: collectionID)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testRemovingPhotoFromCollection() async throws {
        let collectionID = "123"
        let endpoint = Endpoint.removePhotoToCollection(collectionID: collectionID)
        let parameters = UNModifyPhotoToCollectionParameters(photoID: "ABC")
        let queryManager = QueryManager.mock(data: DemoData.standardAddRemoveCollectionsResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .delete,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let _ = try await client.removePhoto(withID: parameters.photoID, fromCollectionWithID: collectionID)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    // MARK: - Topics

    func testListingTopics() async throws {
        let endpoint = Endpoint.topicsList
        let parameters = UNTopicListParameters(idsOrSlugs: ["1", "2"],
                                               pageNumber: 3,
                                               topicsPerPage: 7,
                                               sorting: .oldest)
        let queryManager = QueryManager.mock(data: DemoData.standardTopicList,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let topics = try await client.topicList(idsOrSlugs: parameters.idsOrSlugs,
                                                pageNumber: parameters.pageNumber!,
                                                topicsPerPage: parameters.topicsPerPage!,
                                                sortingBy: parameters.sorting!)

        XCTAssertFalse(topics.isEmpty)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testFetchingATopic() async throws {
        let topicSlug = "Nature"
        let endpoint = Endpoint.topic(idOrSlug: topicSlug)
        let queryManager = QueryManager.mock(data: DemoData.standardTopicResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: nil,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: nil)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let _ = try await client.topic(withIDOrSlug: topicSlug)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    func testPhotosOfTopics() async throws {
        let topicSlug = "Nature"
        let endpoint = Endpoint.photosOfTopic(idOrSlug: topicSlug)
        let parameters = UNTopicPhotosParameters(pageNumber: 3,
                                                 photosPerPage: 7,
                                                 orientation: .landscape,
                                                 order: .oldest)
        let queryManager = QueryManager.mock(data: DemoData.standardPhotosOfTopicResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let photos = try await client.photosOfTopic(idOrSlug: topicSlug,
                                                    pageNumber: parameters.pageNumber!,
                                                    photosPerPage: parameters.photosPerPage!,
                                                    orientation: parameters.orientation!,
                                                    sortingBy: parameters.order!)

        XCTAssertFalse(photos.isEmpty)

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    // MARK: - Stats

    func testFetchingTotalUnsplashStats() async throws {
        let endpoint = Endpoint.unsplashTotalStats
        let queryManager = QueryManager.mock(data: DemoData.standardTotalStatsResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: nil,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: nil)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let _ = try await client.unsplashTotalStats()
    }

    func testFetchingMonthlyUnsplashStats() async throws {
        let endpoint = Endpoint.unsplashMonthlyStats
        let queryManager = QueryManager.mock(data: DemoData.standardMonthlyStatsResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: nil,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: nil)
        let client = UNClient(queryManager: queryManager)

        XCTAssertNil(client.requestsLimit)
        XCTAssertNil(client.requestsRemaining)

        let _ = try await client.unsplashMonthlyStats()

        XCTAssertEqual(client.requestsLimit, Constant.requestsLimit)
        XCTAssertEqual(client.requestsRemaining, Constant.requestRemaining)
    }

    // MARK: - Authentication

    func testAuthorizationURL() {
        let scope: Set<UserAuthorizationScope> = [.readPhotos]
        let queryManager = QueryManager.mock(data: Data(), // No request should be fired on this test
                                             response: nil,
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: 0,
                                             expectedMethod: .get,
                                             expectedEndpoint: .authorization,
                                             expectedParameters: nil)
        let client = UNClient(queryManager: queryManager)

        XCTAssertEqual(client.authorizationURL(scope: scope).absoluteString,
                       "https://unsplash.com/oauth/authorize?client_id=123&redirect_uri=unsplashframework://open/auth&response_type=code&scope=read_photos")
    }

    func testURLIsNotHandledWhenURIDoesNotCoincide() async throws {
        let errorExpectation = expectation(description: "Error is expected")
        let url = URL(string: "unsplashframework://open/something_that_is_not_auth")!
        let queryManager = QueryManager.mock(data: Data(), // No request should be fired on this test
                                             response: nil,
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: 0,
                                             expectedMethod: .get,
                                             expectedEndpoint: .authorization,
                                             expectedParameters: nil)
        let client = UNClient(queryManager: queryManager)

        do {
            try await client.handleAuthorizationCallback(url: url)
            XCTFail()
        } catch {
            errorExpectation.fulfill()
        }

        wait(for: [errorExpectation], timeout: 0.1)
    }

    func testURLWithoutCodeFails() async throws {
        let errorExpectation = expectation(description: "Error is expected")
        let url = URL(string: "unsplashframework://open/auth")!
        let queryManager = QueryManager.mock(data: Data(), // No request should be fired on this test
                                             response: nil,
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: 0,
                                             expectedMethod: .get,
                                             expectedEndpoint: .authorization,
                                             expectedParameters: nil)
        let client = UNClient(queryManager: queryManager)

        do {
            try await client.handleAuthorizationCallback(url: url)
            XCTFail()
        } catch {
            errorExpectation.fulfill()
        }

        wait(for: [errorExpectation], timeout: 0.1)
    }

    func testCorrectURLMakesCorrectRequest() async throws {
        let code = "123"
        let url = URL(string: "unsplashframework://open/auth?code=\(code)")!
        let endpoint = Endpoint.authorizationToken
        let parameters = AuthorizationTokenParameters(credentials: Constant.credentials,
                                                      code: code)
        let queryManager = QueryManager.mock(data: DemoData.standardAuthorizationResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters,
                                                                       headers: Constant.responseHeaders),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .post,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        try await client.handleAuthorizationCallback(url: url)
    }
}
