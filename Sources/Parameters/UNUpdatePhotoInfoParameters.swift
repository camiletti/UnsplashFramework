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

struct UNUpdatePhotoInfoParameters {

    // MARK: - Declarations

    enum QueryParameterName {
        /// The photo’s description.
        static let description = "description"
        /// The photo’s visibility.
        static let showsOnProfile = "show_on_profile"
        /// The photo’s tags.
        static let tags = "tags"
        /// The photo’s full location string (including city and country).
        static let locationFullName = "location[name]"
        /// The photo location’s city.
        static let city = "location[city]"
        /// The photo location’s country.
        static let country = "location[country]"
        /// The photo location’s latitude rounded to 6 decimals.
        static let latitude = "location[latitude]"
        /// The photo location’s longitude rounded to 6 decimals.
        static let longitude = "location[longitude]"
        /// Camera’s brand.
        static let cameraBrand = "exif[make]"
        /// Camera’s model.
        static let cameraModel = "exif[model]"
        /// Camera’s exposure time.
        static let exposureTime = "exif[exposure_time]"
        /// Camera’s aperture value.
        static let aperture = "exif[aperture_value]"
        /// Camera’s focal length.
        static let focalLength = "exif[focal_length]"
        /// Camera’s iso speed ratings.
        static let iso = "exif[iso_speed_ratings]"
    }

    // MARK: - Properties

    /// The photo’s description.
    let description: String?

    /// The photo’s visibility.
    let showsOnProfile: Bool?

    /// The photo’s tags
    let tags: [String]?

    /// The location details to update.
    let location: UNLocation?

    /// The camera details to update.
    let cameraDetails: UNCameraDetails?
}

// MARK: - ParametersURLRepresentable
extension UNUpdatePhotoInfoParameters: ParametersURLRepresentable {

    func asQueryItems() -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()

        if let description {
            queryItems.append(URLQueryItem(name: QueryParameterName.description,
                                           value: description))
        }

        if let showsOnProfile {
            queryItems.append(URLQueryItem(name: QueryParameterName.showsOnProfile,
                                           value: "\(showsOnProfile)"))
        }

        if let tags {
            queryItems.append(URLQueryItem(name: QueryParameterName.tags,
                                           value: tags.joined(separator: ",")))
        }

        if let location {
            queryItems.append(URLQueryItem(name: QueryParameterName.locationFullName,
                                           value: "\(location.name)"))

            queryItems.append(URLQueryItem(name: QueryParameterName.city,
                                           value: "\(location.city)"))

            queryItems.append(URLQueryItem(name: QueryParameterName.country,
                                           value: "\(location.country)"))

            if let coordinates = location.coordinates {
                queryItems.append(URLQueryItem(name: QueryParameterName.latitude,
                                               value: "\(coordinates.latitude)"))

                queryItems.append(URLQueryItem(name: QueryParameterName.longitude,
                                               value: "\(coordinates.longitude)"))
            }
        }

        if let cameraDetails {
            queryItems.append(URLQueryItem(name: QueryParameterName.cameraBrand,
                                           value: "\(cameraDetails.brand)"))

            queryItems.append(URLQueryItem(name: QueryParameterName.cameraModel,
                                           value: "\(cameraDetails.model)"))

            queryItems.append(URLQueryItem(name: QueryParameterName.exposureTime,
                                           value: "\(cameraDetails.exposureTime)"))

            queryItems.append(URLQueryItem(name: QueryParameterName.aperture,
                                           value: "\(cameraDetails.aperture)"))

            queryItems.append(URLQueryItem(name: QueryParameterName.focalLength,
                                           value: "\(cameraDetails.focalLength)"))

            queryItems.append(URLQueryItem(name: QueryParameterName.iso,
                                           value: "\(cameraDetails.iso)"))
        }

        return queryItems
    }
}
