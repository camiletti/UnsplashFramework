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

    func publicProfile(with parameters: UNUserPublicProfileParameters) async throws -> (UNUserPublicProfile, [ResponseHeader]) {
        try await api.request(.get,
                              endpoint: .userPublicProfile(username: parameters.username),
                              at: .api,
                              parameters: parameters)
    }

    func portfolioLink(with parameters: UNUserPublicProfileParameters) async throws -> (UNURLWrapper, [ResponseHeader]) {
        try await api.request(.get,
                              endpoint: .userPortfolioLink(username: parameters.username),
                              at: .api,
                              parameters: parameters)
    }

    func userPhotos(with parameters: UNUserPhotosParameters) async throws -> ([UNPhoto], [ResponseHeader]) {
        try await api.request(.get,
                              endpoint: .userPhotos(username: parameters.username),
                              at: .api,
                              parameters: parameters)
    }

    func userLikedPhotos(with parameters: UNUserLikesParameters) async throws -> ([UNPhoto], [ResponseHeader]) {
        try await api.request(.get,
                              endpoint: .userLikedPhotos(username: parameters.username),
                              at: .api,
                              parameters: parameters)
    }

    func collections(with parameters: UNUserCollectionsParameters) async throws -> ([UNCollection], [ResponseHeader]) {
        try await api.request(.get,
                              endpoint: .userCollections(username: parameters.username),
                              at: .api,
                              parameters: parameters)
    }

    func userStatistics(forUsername username: String, with parameters: UNStatisticsParameters) async throws -> (UNUserStatistics, [ResponseHeader]) {
        try await api.request(.get,
                              endpoint: .userStatistics(username: username),
                              at: .api,
                              parameters: parameters)
    }

    // MARK: - Photos

    func editorialPhotosList(with parameters: UNPhotoListParameters) async throws -> ([UNPhoto], [ResponseHeader]) {
        try await api.request(.get,
                              endpoint: .editorialPhotosList,
                              at: .api,
                              parameters: parameters)
    }

    func photo(withID id: String) async throws -> (UNFullPhoto, [ResponseHeader]) {
        try await api.request(.get,
                              endpoint: .photo(id: id),
                              at: .api,
                              parameters: nil)
    }

    func randomPhotos(with parameters: UNRandomPhotoParameters) async throws -> ([UNFullPhoto], [ResponseHeader]) {
        try await api.request(.get,
                              endpoint: .randomPhoto,
                              at: .api,
                              parameters: parameters)
    }

    func userStatistics(forPhotoWithID photoID: String, with parameters: UNStatisticsParameters) async throws -> (UNPhotoStatistics, [ResponseHeader]) {
        try await api.request(.get,
                              endpoint: .photoStatistics(id: photoID),
                              at: .api,
                              parameters: parameters)
    }

    public func trackPhotoDownloaded(withID photoID: String) async throws -> (UNURLWrapper, [ResponseHeader]) {
        try await api.request(.get,
                              endpoint: .trackPhotoDownload(id: photoID),
                              at: .api,
                              parameters: nil)
    }

    func updatePhotoInfo(forPhotoWithID photoID: String, with parameters: UNUpdatePhotoInfoParameters) async throws -> (UNPhoto, [ResponseHeader]) {
        try await api.request(.put,
                              endpoint: .photo(id: photoID),
                              at: .api,
                              parameters: parameters)
    }

    func likePhoto(withID photoID: String) async throws -> (UNPhoto, [ResponseHeader]) {
        try await api.request(.post,
                              endpoint: .likePhoto(id: photoID),
                              at: .api,
                              parameters: nil)
    }

    func unlikePhoto(withID photoID: String) async throws -> (UNPhoto, [ResponseHeader]) {
        try await api.request(.delete,
                              endpoint: .likePhoto(id: photoID),
                              at: .api,
                              parameters: nil)
    }

    // MARK: - Search

    func search<T>(_ searchType: SearchType,
                   with parameters: ParametersURLRepresentable) async throws -> (UNSearchResult<T>, [ResponseHeader]) {
        try await api.request(.get,
                              endpoint: searchType.endpoint,
                              at: .api,
                              parameters: parameters)
    }

    // MARK: - Collections

    func collectionList(parameters: UNCollectionListParameters) async throws -> ([UNCollection], [ResponseHeader]) {
        try await api.request(.get,
                              endpoint: .collections,
                              at: .api,
                              parameters: parameters)
    }

    func collection(withID id: String) async throws -> (UNCollection, [ResponseHeader]) {
        try await api.request(.get,
                              endpoint: .collection(id: id),
                              at: .api,
                              parameters: nil)
    }

    func photosInCollection(withID collectionID: String, parameters: UNCollectionPhotosParameters) async throws -> ([UNPhoto], [ResponseHeader]) {
        try await api.request(.get,
                              endpoint: .photosInCollection(id: collectionID),
                              at: .api,
                              parameters: parameters)
    }

    func relatedCollections(toCollectionWithID collectionID: String) async throws -> ([UNCollection], [ResponseHeader]) {
        try await api.request(.get,
                              endpoint: .relatedCollections(id: collectionID),
                              at: .api,
                              parameters: nil)
    }

    func createNewCollection(parameters: UNNewCollectionParameters) async throws -> (UNCollection, [ResponseHeader]) {
        try await api.request(.post,
                              endpoint: .collections,
                              at: .api,
                              parameters: parameters)
    }

    func updateCollection(withID collectionID: String, parameters: UNUpdateCollectionParameters) async throws -> (UNCollection, [ResponseHeader]) {
        try await api.request(.put,
                              endpoint: .collection(id: collectionID),
                              at: .api,
                              parameters: parameters)
    }

    func deleteCollection(withID collectionID: String) async throws -> [ResponseHeader] {
        try await api.request(.delete,
                              endpoint: .collection(id: collectionID),
                              at: .api,
                              parameters: nil)
    }

    func addPhotoToCollection(withID collectionID: String, parameters: UNModifyPhotoToCollectionParameters) async throws -> (UNModifyPhotoInCollectionResponse, [ResponseHeader]) {
        try await api.request(.post,
                              endpoint: .addPhotoToCollection(collectionID: collectionID),
                              at: .api,
                              parameters: parameters)
    }

    func removePhotoFromCollection(withID collectionID: String, parameters: UNModifyPhotoToCollectionParameters) async throws -> (UNModifyPhotoInCollectionResponse, [ResponseHeader]) {
        try await api.request(.delete,
                              endpoint: .removePhotoToCollection(collectionID: collectionID),
                              at: .api,
                              parameters: parameters)
    }

    // MARK: - Topics

    func topicList(parameters: UNTopicListParameters) async throws -> ([UNTopic], [ResponseHeader]) {
        try await api.request(.get,
                              endpoint: .topicsList,
                              at: .api,
                              parameters: parameters)
    }

    func topic(withIDOrSlug idOrSlug: String) async throws -> (UNTopic, [ResponseHeader]) {
        try await api.request(.get,
                              endpoint: .topic(idOrSlug: idOrSlug),
                              at: .api,
                              parameters: nil)
    }

    func photosOfTopic(idOrSlug: String, parameters: UNTopicPhotosParameters) async throws -> ([UNPhoto], [ResponseHeader]) {
        try await api.request(.get,
                              endpoint: .photosOfTopic(idOrSlug: idOrSlug),
                              at: .api,
                              parameters: parameters)
    }

    // MARK: - Stats

    func unsplashTotalStats() async throws -> (UNUnsplashTotalStats, [ResponseHeader]) {
        try await api.request(.get,
                              endpoint: .unsplashTotalStats,
                              at: .api,
                              parameters: nil)
    }

    func unsplashMonthlyStats() async throws -> (UNUnsplashMonthlyStats, [ResponseHeader]) {
        try await api.request(.get,
                              endpoint: .unsplashMonthlyStats,
                              at: .api,
                              parameters: nil)
    }

    // MARK: - Authorization

    func authorizationURL(scope: Set<UserAuthorizationScope>) -> URL {
        api.authorizationURL(scope: scope)
    }

    func handleAuthorizationCallback(url: URL) async throws {
        try await api.handleAuthorizationCallback(url: url)
    }
}
