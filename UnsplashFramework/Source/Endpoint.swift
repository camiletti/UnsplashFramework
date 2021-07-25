//
//  Endpoint.swift
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

/// Endpoints Unsplash supports
enum Endpoint {

    // MARK: - General photos

    /// List of photos.
    case photos
    /// List of the curated photos.
    case curatedPhotos
    /// Retrieve a single random photo, given optional filters.
    case randomPhoto

    // MARK: - Single photos

    /// Retrieve a single photo.
    case singlePhoto(String)
    /// Retrieve total number of downloads, views and likes of a single photo,
    /// as well as the historical breakdown of these stats in a specific timeframe.
    case singlePhotoStatistics(String)
    /// Retrieve a single photo’s download link.
    case singlePhotoDownload(String)
    /// Un/Like a photo on behalf of the logged-in user.
    case singlePhotoLike(String)

    // MARK: - Search

    /// Get the photo results for a query.
    case photoSearch
    /// Get the collection results for a query.
    case collectionSearch
    /// Get the user results for a query.
    case userSearch

    // MARK: - General collections

    /// List of all collections.
    case collections
    /// List of featured collections.
    case featuredCollections
    /// List of curated collections.
    case curatedCollections

    // MARK: - Single collections

    /// Retrieve a single collection.
    case singleCollection(String)

    /// Retrieve a curated collection.
    case singleCuratedCollection(String)

    // MARK: - Photos in a collection

    /// Retrieve a collection’s photos.
    case photosInCollection(String)
    /// Retrieve a curated collection’s photos.
    case photosInCuratedCollection(String)

    // MARK: - Related collections

    /// Retrieve a list of collections related to this one.
    case relatedCollections(String)

    // MARK: - Unsplash stats

    /// Get a list of counts for all of Unsplash.
    case unsplashTotalStats
    /// Get the overall Unsplash stats for the past 30 days.
    case unsplashMonthlyStats

    // MARK: - To string

    /// Returns the string form for the endpoint.
    func string() -> String {
        switch self {
        case .photos:
            return "/photos"

        case .curatedPhotos:
            return "/photos/curated"

        case .randomPhoto:
            return "/photos/random"

        case .singlePhoto(let id):
            return "/photos/" + id

        case .singlePhotoStatistics(let id):
            return "/photos/" + id + "/statistics"

        case .singlePhotoDownload(let id):
            return "/photos/" + id + "/download"

        case .singlePhotoLike(let id):
            return "/photos/" + id + "/like"

        case .photoSearch:
            return "/search/photos"

        case .collectionSearch:
            return "/search/collections"

        case .userSearch:
            return "/search/users"

        case .collections:
            return "/collections"

        case .featuredCollections:
            return "/collections/featured"

        case .curatedCollections:
            return "/collections/curated"

        case .singleCollection(let id):
            return "/collections/" + id

        case .singleCuratedCollection(let id):
            return "/collections/curated/" + id

        case .photosInCollection(let id):
            return "/collections/" + id + "/photos"

        case .photosInCuratedCollection(let id):
            return "/collections/curated/" + id + "/photos"

        case .relatedCollections(let id):
            return "/collections/" + id + "/related"

        case .unsplashTotalStats:
            return "/stats/total"

        case .unsplashMonthlyStats:
            return "/stats/month"
        }
    }
}
