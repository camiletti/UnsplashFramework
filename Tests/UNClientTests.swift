//
//  UNClientTests.swift
//  UnsplashFrameworkTests
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

import Foundation
@testable import UnsplashFramework
import XCTest

final class UNClientTests: XCTestCase {

    // MARK: - Declarations

    private enum Constant {
        static let requestDeadline = 0.2
        static let credentials = UNCredentials(accessKey: "123", secret: "789")
    }

    // MARK: - Users

    func testPublicUserProfile() async throws {
        // The only important parameter for this test is the data that will be returned
        let username = "camiletti"
        let endpoint = Endpoint.userPublicProfile(username: username)
        let parameters = UNUserPublicProfileParameters(username: username)
        let queryManager = QueryManager.mock(data: DemoData.userPublicProfileResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        // None of the parameters are relevant for this test
        let _ = try await client.publicProfile(forUsername: username)
    }

    func testUserPortfolio() async throws {
        let username = "camiletti"
        let endpoint = Endpoint.userPortfolioLink(username: username)
        let parameters = UNUserPublicProfileParameters(username: username)
        let queryManager = QueryManager.mock(data: DemoData.userPortfolioResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        // None of the parameters are relevant for this test
        let _ = try await client.portfolioLink(forUsername: username)
    }

    func testUserPhotos() async throws {
        let parameters = UNUserPhotosParameters(username: "camiletti",
                                                pageNumber: 2,
                                                photosPerPage: 4,
                                                sorting: .downloads,
                                                includeStats: true,
                                                statsAmount: 30,
                                                orientationFilter: .landscape)
        let endpoint = Endpoint.userPhotos(username: parameters.username)
        let queryManager = QueryManager.mock(data: DemoData.userPhotosResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        // None of the parameters are relevant for this test
        let _ = try await client.photos(fromUsername: parameters.username,
                                        pageNumber: parameters.pageNumber!,
                                        photosPerPage: parameters.photosPerPage!,
                                        sorting: parameters.sorting!,
                                        includeStats: parameters.includeStats!,
                                        statsAmount: parameters.statsAmount!,
                                        orientationFilter: parameters.orientationFilter)
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
                                                                       parameters: parameters),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        // None of the parameters are relevant for this test
        let _ = try await client.photosLiked(byUsername: parameters.username,
                                             pageNumber: parameters.pageNumber!,
                                             photosPerPage: parameters.photosPerPage!,
                                             sorting: parameters.sorting!,
                                             orientationFilter: parameters.orientationFilter)
    }

    // MARK: - Photos

    func testListingPhotos() async throws {
        let endpoint = Endpoint.editorialPhotosList
        let parameters = UNPhotoListParameters(pageNumber: 2,
                                               photosPerPage: 4,
                                               sortOrder: .latest)
        let queryManager = QueryManager.mock(data: DemoData.standardPhotoListResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        // None of the parameters are relevant for this test
        let photos = try await client.editorialPhotosList(page: parameters.pageNumber,
                                                          photosPerPage: parameters.photosPerPage,
                                                          sortingBy: parameters.sortOrder)
        XCTAssertFalse(photos.isEmpty)
    }

    // MARK: - Search

    func testSearchPhotos() async throws {
        let endpoint = SearchType.photo.endpoint
        let parameters = UNPhotoSearchParameters(query: "camiletti",
                                                 pageNumber: 2,
                                                 photosPerPage: 4,
                                                 collections: [],
                                                 orientation: .landscape)
        let queryManager = QueryManager.mock(data: DemoData.standardPhotoSearchResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        // None of the parameters are relevant for this test
        let photosSearchResult = try await client.searchPhotos(query: parameters.query,
                                                               page: parameters.pageNumber,
                                                               photosPerPage: parameters.photosPerPage,
                                                               collections: parameters.collections,
                                                               orientation: parameters.orientation)
        XCTAssertFalse(photosSearchResult.elements.isEmpty)
    }

    func testSearchCollection() async throws {
        let endpoint = SearchType.collection.endpoint
        let parameters = UNCollectionSearchParameters(query: "camiletti",
                                                      pageNumber: 2,
                                                      collectionsPerPage: 4)
        let queryManager = QueryManager.mock(data: DemoData.standardCollectionSearchResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: nil),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        // None of the parameters are relevant for this test
        let collectionsSearchResult = try await client.searchCollections(query: parameters.query,
                                                                         page: parameters.pageNumber,
                                                                         collectionsPerPage: parameters.collectionsPerPage)

        XCTAssertFalse(collectionsSearchResult.elements.isEmpty)
    }

    func testSearchUsers() async throws {
        let endpoint = SearchType.user.endpoint
        let parameters = UNUserSearchParameters(query: "camiletti",
                                                pageNumber: 2,
                                                usersPerPage: 4)
        let queryManager = QueryManager.mock(data: DemoData.standardUserSearchResponse,
                                             response: .mockingSuccess(endpoint: endpoint,
                                                                       parameters: parameters),
                                             error: nil,
                                             credentials: Constant.credentials,
                                             deadline: Constant.requestDeadline,
                                             expectedMethod: .get,
                                             expectedEndpoint: endpoint,
                                             expectedParameters: parameters)
        let client = UNClient(queryManager: queryManager)

        // None of the parameters are relevant for this test
        let usersSearchResult = try await client.searchUsers(query: parameters.query,
                                                             page: parameters.pageNumber,
                                                             usersPerPage: parameters.usersPerPage)

        XCTAssertFalse(usersSearchResult.elements.isEmpty)
    }
}
