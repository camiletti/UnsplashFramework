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

/// Class aimed to simplify getting sample JSON data
enum DemoData {

    // MARK: - Declarations

    enum Constant {
        static let invalidURL = URL(string: "https://unsplash.com/rewqkjfdasaosnfhwlawfhyuip")!
    }

    // MARK: - Users

    /// Returns a sample public user profile.
    ///
    /// - Returns: JSON Data representing the user's public profile.
    static var userPublicProfileResponse: Data {
        dataFromJSONFile(named: "UserPublicProfileResponse")
    }

    /// Returns a sample user portfolio.
    ///
    /// - Returns: JSON Data representing the user's portfolio.
    static var userPortfolioResponse: Data {
        dataFromJSONFile(named: "URLWrapper")
    }

    /// Returns a sample of user photos.
    ///
    /// - Returns: JSON Data representing the user's photos.
    static var userPhotosResponse: Data {
        dataFromJSONFile(named: "UserPhotos")
    }

    /// Returns a sample of photos liked by a user.
    ///
    /// - Returns: JSON Data representing the photos liked by a user.
    static var userLikesResponse: Data {
        dataFromJSONFile(named: "UserLikes")
    }

    /// Returns a sample of collections by a user.
    ///
    /// - Returns: JSON Data representing the collections by a user.
    static var userCollectionsResponse: Data {
        dataFromJSONFile(named: "UserCollections")
    }

    /// Returns a sample of statistics of a user.
    ///
    /// - Returns: JSON Data representing the statistics of a user.
    static var userStatisticsResponse: Data {
        dataFromJSONFile(named: "UserStatistics")
    }

    // MARK: - Photos

    /// Returns a sample list of photos.
    ///
    /// - Returns: JSON Data of the list of photos.
    static var standardPhotoListResponse: Data {
        dataFromJSONFile(named: "StandardPhotoList")
    }

    /// Returns a sample of a photo.
    ///
    /// - Returns: JSON Data of a photo.
    static var standardPhotoAResponse: Data {
        dataFromJSONFile(named: "PhotoA")
    }

    /// Returns a sample of a photo.
    ///
    /// - Returns: JSON Data of a photo.
    static var standardPhotoBResponse: Data {
        dataFromJSONFile(named: "PhotoB")
    }

    /// Returns a sample of random photos when using the
    /// search query parameter in the request.
    ///
    /// - Returns: JSON Data of random photos.
    static var standardRandomPhotosByQueryResponse: Data {
        dataFromJSONFile(named: "RandomPhotosByQuery")
    }

    /// Returns a sample of random photos when using
    /// collection IDs as parameter in the request.
    ///
    /// - Returns: JSON Data of random photos.
    static var standardRandomPhotosWithQueryResponse: Data {
        dataFromJSONFile(named: "RandomPhotosByCollectionIDs")
    }

    /// Returns a sample when calling track download.
    ///
    /// - Returns: JSON Data when calling track download.
    static var standardTrackPhotoDownload: Data {
        dataFromJSONFile(named: "TrackPhotoDownload")
    }

    // MARK: - Search

    /// Returns a sample search of photos.
    ///
    /// - Returns: JSON Data of the search
    static var standardPhotoSearchResponse: Data {
        dataFromJSONFile(named: "StandardSearchPhotoResult")
    }

    /// Returns a sample search of collections.
    ///
    /// - Returns: JSON Data of the search
    static var standardCollectionSearchResponse: Data {
        dataFromJSONFile(named: "StandardSearchCollectionResult")
    }

    /// Returns a sample search of users.
    ///
    /// - Returns: JSON Data of the search
    static var standardUserSearchResponse: Data {
        dataFromJSONFile(named: "StandardSearchUserResult")
    }

    /// Returns a sample of statistics of a photo.
    ///
    /// - Returns: JSON Data representing the statistics of a photo.
    static var photoStatisticsResponse: Data {
        dataFromJSONFile(named: "PhotoStatistics")
    }

    // MARK: - Collections

    /// Returns a sample of a collection.
    ///
    /// - Returns: JSON Data of a collection.
    static var standardCollectionAResponse: Data {
        dataFromJSONFile(named: "CollectionA")
    }

    /// Returns a sample of a collection.
    ///
    /// - Returns: JSON Data of a collection.
    static var standardCollectionBResponse: Data {
        dataFromJSONFile(named: "CollectionB")
    }

    /// Returns a sample of a list of collections.
    ///
    /// - Returns: JSON Data of a collection.
    static var standardCollectionListResponse: Data {
        dataFromJSONFile(named: "CollectionList")
    }

    /// Returns a sample of photos in a collection.
    ///
    /// - Returns: JSON Data of a collection.
    static var standardPhotosInCollectionResponse: Data {
        dataFromJSONFile(named: "PhotosInCollection")
    }

    /// Returns a sample of related collections.
    ///
    /// - Returns: JSON Data of related collections.
    static var standardRelatedCollectionsResponse: Data {
        dataFromJSONFile(named: "RelatedCollections")
    }

    /// Returns a sample respond after adding or deleting a photo from a collection.
    ///
    /// - Returns: JSON Data of related collections.
    static var standardAddRemoveCollectionsResponse: Data {
        dataFromJSONFile(named: "AddRemovePhotoInCollection")
    }

    // MARK: - Topics

    /// Returns a sample respond of a list of topics.
    ///
    /// - Returns: JSON Data of a list of topics.
    static var standardTopicList: Data {
        dataFromJSONFile(named: "StandardTopicList")
    }

    /// Returns a sample respond of a topic.
    ///
    /// - Returns: JSON Data of a topic.
    static var standardTopicResponse: Data {
        dataFromJSONFile(named: "Topic")
    }

    /// Returns a sample respond of photos belonging to a topic.
    ///
    /// - Returns: JSON Data of photos belonging to a topic.
    static var standardPhotosOfTopicResponse: Data {
        dataFromJSONFile(named: "PhotosOfTopic")
    }

    // MARK: - Stats

    /// Returns a sample respond of total Unsplash stats.
    ///
    /// - Returns: JSON Data of total Unsplash stats.
    static var standardTotalStatsResponse: Data {
        dataFromJSONFile(named: "TotalStats")
    }

    /// Returns a sample respond of monthly Unsplash stats.
    ///
    /// - Returns: JSON Data of monthly Unsplash stats.
    static var standardMonthlyStatsResponse: Data {
        dataFromJSONFile(named: "MonthlyStats")
    }

    // MARK: - Athorization

    /// Returns a sample response of a successful authorization
    ///
    /// - Returns: JSON Data of a successful authorization.
    static var standardAuthorizationResponse: Data {
        dataFromJSONFile(named: "Authorization")
    }

    // MARK: - General purpose models

    /// Returns a sample of a CLLocationCoordinates2D.
    ///
    /// - Returns: JSON Data of a CLLocationCoordinates2D.
    static var standardCLCoordinates2D: Data {
        dataFromJSONFile(named: "CLLocationCoordinates2D")
    }

    /// Returns a sample of a location.
    ///
    /// - Returns: JSON Data of a location.
    static var standardLocation: Data {
        dataFromJSONFile(named: "Location")
    }

    /// Returns a sample of a location with optional values missing.
    ///
    /// - Returns: JSON Data of a location.
    static var locationWithNulls: Data {
        dataFromJSONFile(named: "LocationWithNulls")
    }

    /// Returns a sample of a camera details.
    ///
    /// - Returns: JSON Data of a camera details.
    static var standardCameraDetails: Data {
        dataFromJSONFile(named: "CameraDetails")
    }

    // MARK: - Decoded entities

    static var photoA: UNFullPhoto {
        let jsonData = DemoData.standardPhotoAResponse
        let decoder = JSONDecoder.unsplashDecoder
        return try! decoder.decode(UNFullPhoto.self, from: jsonData)
    }

    static var photoB: UNFullPhoto {
        let jsonData = DemoData.standardPhotoBResponse
        let decoder = JSONDecoder.unsplashDecoder
        return try! decoder.decode(UNFullPhoto.self, from: jsonData)
    }

    static var collectionA: UNCollection {
        let jsonData = DemoData.standardCollectionAResponse
        let decoder = JSONDecoder.unsplashDecoder
        return try! decoder.decode(UNCollection.self, from: jsonData)
    }

    static var collectionB: UNCollection {
        let jsonData = DemoData.standardCollectionBResponse
        let decoder = JSONDecoder.unsplashDecoder
        return try! decoder.decode(UNCollection.self, from: jsonData)
    }

    static var location: UNLocation {
        let jsonData = DemoData.standardLocation
        let decoder = JSONDecoder.unsplashDecoder
        return try! decoder.decode(UNLocation.self, from: jsonData)
    }

    static var cameraDetails: UNCameraDetails {
        let jsonData = DemoData.standardCameraDetails
        let decoder = JSONDecoder.unsplashDecoder
        return try! decoder.decode(UNCameraDetails.self, from: jsonData)
    }

    static var validUser: UNUser {
        UNUser(id: "QV5S1rtoUJ0",
               username: "unsplash",
               name: "Unsplash",
               firstName: "Unsplash",
               lastName: nil,
               twitterUsername: "unsplash",
               portfolioURL: URL(string: "http://unsplash.com"),
               bio: "Make something awesome.",
               location: "Montreal, Canada",
               totalLikes: 18708,
               totalPhotos: 0,
               totalCollections: 126,
               profileImageLinks: validProfileImageLinks,
               apiLocations: validUserAPILocations)
    }

    static var validCollectionAPILocations: UNCollectionAPILocations {
        UNCollectionAPILocations(apiCollectionURL: URL(string: "https://api.unsplash.com/collections/334800")!,
                                 apiPhotosInCollectionURL: URL(string: "https://api.unsplash.com/collections/334800/photos")!,
                                 externalCollectionURL: URL(string: "https://unsplash.com/collections/334800/unsplashframework-testing")!)
    }

    static var validProfileImageLinks: UNProfileImageLinks {
        UNProfileImageLinks(small: URL(string: "https://images.unsplash.com/profile-1441945026710-480e4372a5b5?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=32&w=32&s=6676f08bc1f6638d9d97e28f53252937")!,
                            medium: URL(string: "https://images.unsplash.com/profile-1441945026710-480e4372a5b5?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64&s=fb59ebefbd52e943eb5abf68d7edc020")!,
                            large: URL(string: "https://images.unsplash.com/profile-1441945026710-480e4372a5b5?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=128&w=128&s=a506ec7dcb2fe02cb7089bea78c4df68")!)
    }

    static var validUserAPILocations: UNUserAPILocations {
        UNUserAPILocations(apiProfileURL: URL(string: "https://api.unsplash.com/users/unsplash")!,
                           apiPhotosURL: URL(string: "https://api.unsplash.com/users/unsplash/photos")!,
                           apiLikesURL: URL(string: "https://api.unsplash.com/users/unsplash/likes")!,
                           apiPortfolioURL: URL(string: "https://api.unsplash.com/users/unsplash/portfolio")!,
                           apiFollowingURL: URL(string: "https://api.unsplash.com/users/unsplash/following")!,
                           apiFollowersURL: URL(string: "https://api.unsplash.com/users/unsplash/followers")!,
                           externalProfileURL: URL(string: "https://unsplash.com/@unsplash")!)
    }

    // MARK: - Invalid data

    /// Creates a new invalid UNUser
    static var invalidUser: UNUser {
        let invalidNumber = -999

        return UNUser(id: "fdajnfdjoaeisamasofjasdiofnosdfosdanoifasd",
                      username: "pfiewoijska oidjsjfsodaoiadsjfoidsji",
                      name: nil,
                      firstName: nil,
                      lastName: nil,
                      twitterUsername: nil,
                      portfolioURL: nil,
                      bio: nil,
                      location: nil,
                      totalLikes: invalidNumber,
                      totalPhotos: invalidNumber,
                      totalCollections: invalidNumber,
                      profileImageLinks: invalidProfileImageLinks,
                      apiLocations: invalidUserAPILocations)
    }

    /// Creates an invalid category
    static var invalidCategory: UNCategory {
        UNCategory(id: 12345,
                   title: "Fake category",
                   photoAmount: 999,
                   apiLocations: invalidCategoryAPILocations)
    }

    /// Creates an invalid category
    static var invalidCategoryAPILocations: UNCategoryAPILocations {
        UNCategoryAPILocations(apiCategoryURL: Constant.invalidURL,
                               apiPhotosInCategoryURL: Constant.invalidURL)
    }

    /// Creates an invalid collection
    static var invalidCollectionAPILocations: UNCollectionAPILocations {
        UNCollectionAPILocations(apiCollectionURL: Constant.invalidURL,
                                 apiPhotosInCollectionURL: Constant.invalidURL,
                                 externalCollectionURL: Constant.invalidURL)
    }

    /// Creates an invalid profile image links
    static var invalidProfileImageLinks: UNProfileImageLinks {
        UNProfileImageLinks(small: Constant.invalidURL,
                            medium: Constant.invalidURL,
                            large: Constant.invalidURL)
    }

    /// Creates an invalid photo API locations
    static var invalidPhotoAPILocations: UNPhotoAPILocations {
        UNPhotoAPILocations(apiPhotoURL: Constant.invalidURL,
                            apiDownloadURL: Constant.invalidURL,
                            externalPhotoURL: Constant.invalidURL,
                            externalDownloadURL: Constant.invalidURL)
    }

    /// Creates an invalid user API locations
    static var invalidUserAPILocations: UNUserAPILocations {
        UNUserAPILocations(apiProfileURL: Constant.invalidURL,
                           apiPhotosURL: Constant.invalidURL,
                           apiLikesURL: Constant.invalidURL,
                           apiPortfolioURL: Constant.invalidURL,
                           apiFollowingURL: Constant.invalidURL,
                           apiFollowersURL: Constant.invalidURL,
                           externalProfileURL: Constant.invalidURL)
    }

    // MARK: - Helpers

    /// Opens and returns the content of a .json file. This should be on the Tests' bundle.
    ///
    /// - Parameter named: Name of the JSON File.
    /// - Returns: JSON Data contained on the specified file.
    static func dataFromJSONFile(named: String) -> Data {
        let jsonFilePath = Bundle.module.path(forResource: named, ofType: ".json")!
        let url = URL(fileURLWithPath: jsonFilePath)
        return try! Data(contentsOf: url)
    }
}
