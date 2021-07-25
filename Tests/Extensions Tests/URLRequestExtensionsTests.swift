//
//  URLRequestExtensionsTests.swift
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

@testable import UnsplashFramework
import XCTest

final class URLSessionExtensionsTests: XCTestCase {

    // MARK: - Test request generation

    func testCreatingAPublicRequestForEveryEndpoint() {
        // Parameters
        let id = "abc"
        let credentials = UNCredentials(appID: "123", secret: "789")
        let headers: [UNAPI.Header] = [UNAPI.Header.acceptVersion,
                                       UNAPI.Header.authorization(appID: credentials.appID)]
        let parameters = UNPhotoListParameters(pageNumber: 1,
                                               photosPerPage: 10,
                                               sortOrder: .popular)
        let endpoints: [Endpoint] = [.photos, .curatedPhotos, .randomPhoto,
                                     .singlePhoto(id), .singlePhotoStatistics(id),
                                     .singlePhotoDownload(id), .singlePhotoLike(id),
                                     .photoSearch, .collectionSearch, .userSearch,
                                     .collections, .featuredCollections, .curatedCollections,
                                     .singleCollection(id), .singleCuratedCollection(id),
                                     .photosInCollection(id), .photosInCuratedCollection(id),
                                     .relatedCollections(id), .unsplashTotalStats,
                                     .unsplashMonthlyStats]

        for endpoint in endpoints {
            // Expected results
            let expectedURL = self.expectedURL(withEndpoint: endpoint, parameters: parameters)

            // Function to test
            let request = URLRequest.publicRequest(.get,
                                                   forEndpoint: endpoint,
                                                   parameters: parameters,
                                                   headers: headers)

            // Assertions
            XCTAssert(request.httpMethod == UNAPI.HTTPMethod.get.rawValue)
            XCTAssert(request.url == expectedURL)
            headers.forEach { header in
                XCTAssert(request.value(forHTTPHeaderField: header.fieldName) == header.fieldValue)
            }
        }
    }

    // MARK: - Helpers

    func expectedURL(withEndpoint endpoint: Endpoint, parameters: UNPhotoListParameters) -> URL? {
        URL(string: UNAPI.scheme + "://" + UNAPI.location + endpoint.string() + "?" +
                UNPhotoListParameters.QueryParameterName.pageNumberName + "=\(parameters.pageNumber)&" +
                UNPhotoListParameters.QueryParameterName.photosPerPageName + "=\(parameters.photosPerPage)&" +
                UNPhotoListParameters.QueryParameterName.sortOrderName + "=\(parameters.sortOrder)")
    }
}
