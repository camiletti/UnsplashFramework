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

/// Endpoints Unsplash supports
enum Endpoint {

    // MARK: - Users

    /// Get public details on a given user.
    case userPublicProfile(username: String)
    /// Get a user’s portfolio link.
    case userPortfolioLink(username: String)
    /// Get a list of photos uploaded by a user.
    case userPhotos(username: String)
    /// Get a list of photos liked by a user.
    case userLikedPhotos(username: String)
    /// Get a list of collections created by the user.
    case userCollections(username: String)
    /// Retrieve the consolidated number of downloads, views
    /// and likes of all user’s photos, as well as the historical breakdown
    /// and average of these stats in a specific timeframe (default is 30 days).
    case userStatistics(username: String)

    // MARK: - Photos

    /// Get a single page from the Editorial feed.
    case editorialPhotosList
    /// Retrieve a single photo.
    /// Also updates a photo on behalf of the logged-in user. This requires the `write_photos` scope.
    case photo(id: String)
    /// Retrieve a single random photo, given optional filters.
    case randomPhoto
    /// Retrieve total number of downloads, views and likes of
    /// a single photo, as well as the historical breakdown of these
    /// stats in a specific timeframe (default is 30 days).
    case photoStatistics(id: String)
    /// Track a photo download.
    case trackPhotoDownload(id: String)
    /// Un/Like a photo on behalf of the logged-in user.
    case likePhoto(id: String)

    // MARK: - Search

    /// Get the photo results for a query.
    case photoSearch
    /// Get the collection results for a query.
    case collectionSearch
    /// Get the user results for a query.
    case userSearch

    // MARK: - General collections

    /// Get a single page from the list of all collections.
    /// Also used to create a new collection. This requires the `write_collections` scope.
    case collections
    /// Retrieve a single collection. To view a user’s private collections, the `read_collections` scope is required.
    /// Also used to update an existing collection.
    /// Also used to delete an existing collection.
    case collection(id: String)
    /// Retrieve a collection’s photos.
    case photosInCollection(id: String)
    /// Retrieve a list of collections related to this one.
    case relatedCollections(id: String)
    /// Add a photo to one of the logged-in user’s collections. Requires the `write_collections` scope.
    case addPhotoToCollection(collectionID: String)
    /// Remove a photo from one of the logged-in user’s collections. Requires the write_collections scope.
    case removePhotoToCollection(collectionID: String)

    // MARK: - Topics

    /// Get a single page from the list of all topics.
    case topicsList
    /// Retrieve a single topic.
    case topic(idOrSlug: String)
    /// Retrieve a topic’s photos.
    case photosOfTopic(idOrSlug: String)

    // MARK: - Unsplash stats

    /// Get a list of counts for all of Unsplash.
    case unsplashTotalStats
    /// Get the overall Unsplash stats for the past 30 days.
    case unsplashMonthlyStats

    // MARK: - Authorization

    /// Request permission to the user of a certain scope
    case authorization

    /// Request Unsplash a new access token that includes the requested user priviledges
    case authorizationToken

    // MARK: - Path

    /// Returns the path of the endpoint.
    var path: String {
        switch self {
        case .userPublicProfile(let username):
            return "/users/\(username)"

        case .userPortfolioLink(let username):
            return "/users/\(username)/portfolio"

        case .userPhotos(let username):
            return "/users/\(username)/photos"

        case .userLikedPhotos(let username):
            return "/users/\(username)/likes"

        case .userCollections(let username):
            return "/users/\(username)/collections"

        case .userStatistics(let username):
            return "/users/\(username)/statistics"

        case .editorialPhotosList:
            return "/photos"

        case .photo(let id):
            return "/photos/\(id)"

        case .randomPhoto:
            return "/photos/random"

        case .photoStatistics(let id):
            return "/photos/\(id)/statistics"

        case .trackPhotoDownload(let id):
            return "/photos/\(id)/download"

        case .likePhoto(let id):
            return "/photos/\(id)/like"

        case .photoSearch:
            return "/search/photos"

        case .collectionSearch:
            return "/search/collections"

        case .userSearch:
            return "/search/users"

        case .collections:
            return "/collections"

        case .collection(let id):
            return "/collections/\(id)"

        case .photosInCollection(let id):
            return "/collections/\(id)/photos"

        case .relatedCollections(let id):
            return "/collections/\(id)/related"

        case .addPhotoToCollection(let collectionID):
            return "/collections/\(collectionID)/add"

        case .removePhotoToCollection(let collectionID):
            return "/collections/\(collectionID)/remove"

        case .topicsList:
            return "/topics"

        case .topic(let idOrSlug):
            return "/topics/\(idOrSlug)"

        case .photosOfTopic(let idOrSlug):
            return "/topics/\(idOrSlug)/photos"

        case .unsplashTotalStats:
            return "/stats/total"

        case .unsplashMonthlyStats:
            return "/stats/month"

        case .authorization:
            return "/oauth/authorize"

        case .authorizationToken:
            return "/oauth/token"
        }
    }
}

// MARK: - SearchType extension
extension SearchType {

    /// Extension to get the endpoint for a type of search
    var endpoint: Endpoint {
        switch self {
        case .photo:
            return .photoSearch

        case .collection:
            return .collectionSearch

        case .user:
            return .userSearch
        }
    }
}
