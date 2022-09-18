//
//  QueryManager.swift
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

import Foundation

class QueryManager {

    // MARK: - Properties

    /// Session used for querying Unsplash.
    private let api: UNAPI

    // MARK: - Life Cycle

    /// Creates a client with the specified credentials.
    ///
    /// - Parameters:
    ///   - credentials: The Unsplash client credentials.
    init(api: UNAPI) {
        self.api = api
    }

    // MARK: - Users

    func publicProfile(with parameters: UNUserPublicProfileParameters) async throws -> UNUserPublicProfile {
        try await api.request(.get,
                              endpoint: .userPublicProfile(username: parameters.username),
                              parameters: parameters)
    }

    func portfolioLink(with parameters: UNUserPublicProfileParameters) async throws -> UNURLWrapper {
        try await api.request(.get,
                              endpoint: .userPortfolioLink(username: parameters.username),
                              parameters: parameters)
    }

    func userPhotos(with parameters: UNUserPhotosParameters) async throws -> [UNPhoto] {
        try await api.request(.get,
                              endpoint: .userPhotos(username: parameters.username),
                              parameters: parameters)
    }

    func userLikedPhotos(with parameters: UNUserLikesParameters) async throws -> [UNPhoto] {
        try await api.request(.get,
                              endpoint: .userLikedPhotos(username: parameters.username),
                              parameters: parameters)
    }

    func collections(with parameters: UNUserCollectionsParameters) async throws -> [UNCollection] {
        try await api.request(.get,
                              endpoint: .userCollections(username: parameters.username),
                              parameters: parameters)
    }

    func userStatistics(forUsername username: String, with parameters: UNStatisticsParameters) async throws -> UNUserStatistics {
        try await api.request(.get,
                              endpoint: .userStatistics(username: username),
                              parameters: parameters)
    }

    // MARK: - Photos
    func editorialPhotosList(with parameters: UNPhotoListParameters) async throws -> [UNPhoto] {
        try await api.request(.get,
                              endpoint: .editorialPhotosList,
                              parameters: parameters)
    }

    func photo(withID id: String) async throws -> UNFullPhoto {
        try await api.request(.get,
                              endpoint: .photo(id: id),
                              parameters: nil)
    }

    func randomPhotos(with parameters: UNRandomPhotoParameters) async throws -> [UNFullPhoto] {
        try await api.request(.get,
                              endpoint: .randomPhoto,
                              parameters: parameters)
    }

    func userStatistics(forPhotoWithID photoID: String, with parameters: UNStatisticsParameters) async throws -> UNPhotoStatistics {
        try await api.request(.get,
                              endpoint: .photoStatistics(id: photoID),
                              parameters: parameters)
    }

    public func trackPhotoDownloaded(withID photoID: String) async throws -> UNURLWrapper {
        try await api.request(.get,
                              endpoint: .trackPhotoDownload(id: photoID),
                              parameters: nil)
    }

    func updatePhotoInfo(forPhotoWithID photoID: String, with parameters: UNUpdatePhotoInfoParameters) async throws -> UNPhoto {
        try await api.request(.put,
                              endpoint: .photo(id: photoID),
                              parameters: parameters)
    }

    func likePhoto(withID photoID: String) async throws -> UNPhoto {
        try await api.request(.post,
                              endpoint: .likePhoto(id: photoID),
                              parameters: nil)
    }

    func unlikePhoto(withID photoID: String) async throws -> UNPhoto {
        try await api.request(.delete,
                              endpoint: .likePhoto(id: photoID),
                              parameters: nil)
    }

    /// Makes a query to Unsplash.
    ///
    /// - Parameters:
    ///   - searchType: The type of search to perform.
    ///   - parameters: Parameters to narrow the search.
    func search<T>(_ searchType: SearchType,
                   with parameters: ParametersURLRepresentable)  async throws -> UNSearchResult<T> {
        try await api.request(.get,
                              endpoint: searchType.endpoint,
                              parameters: parameters)
    }
}
