//
//  URLRequestExtensionsTests.swift
//  UnsplashFrameworkTests
//
//  Copyright 2017 Pablo Camiletti
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


import XCTest
@testable import UnsplashFramework


class URLSessionExtensionsTests: XCTestCase
{
    
    // MARK: - Test request generation
    
    func testCreatingAPublicRequestForEveryEndpoint()
    {
        // Parameters
        let id = "abc"
        let authHeaderValue = "Client-ID " + UnsplashKeys.appID
        let parameters = PhotoListParameters(pageNumber: 1,
                                             photosPerPage: 10,
                                             sortOrder: .popular)
        let endpoints : [Endpoint] = [.photos, .curatedPhotos, .randomPhoto,
                                      .singlePhoto(id), .singlePhotoStatistics(id),
                                      .singlePhotoDownload(id), .singlePhotoLike(id),
                                      .photoSearch, .collectionSearch, .userSearch,
                                      .collections, .featuredCollections, .curatedCollections,
                                      .singleCollection(id), .singleCuratedCollection(id),
                                      .photosInCollection(id), .photosInCuratedCollection(id),
                                      .relatedCollections(id), .unsplashTotalStats,
                                      .unsplashMonthlyStats]
        
        for endpoint in endpoints
        {
            // Expected results
            let expectedURL = self.expectedURL(withEndpoint: endpoint, parameters: parameters)
            
            // Function to test
            let request = URLRequest.publicRequest(HTTPMethod.get,
                                                   forEndpoint: endpoint,
                                                   parameters: parameters,
                                                   credentials: UNCredentials(appID: UnsplashKeys.appID, secret: UnsplashKeys.secret))
            
            // Assertions
            XCTAssert(request.httpMethod == HTTPMethod.get.rawValue)
            XCTAssert(request.url == expectedURL)
            XCTAssert(request.value(forHTTPHeaderField: APIAuthorizationHeader.field) == authHeaderValue)
            XCTAssert(request.value(forHTTPHeaderField: APIVersionHeader.field) == APIVersionHeader.value)
        }
    }
    
    
    // MARK: - Helpers
    
    func expectedURL(withEndpoint endpoint: Endpoint, parameters: PhotoListParameters) -> URL?
    {
        return URL(string: APIScheme + "://" + APILocation + endpoint.string() + "?" +
                           PhotoListParameters.pageNumberName + "=\(parameters.pageNumber)&" +
                           PhotoListParameters.photosPerPage  + "=\(parameters.photosPerPage)&" +
                           PhotoListParameters.sortOrderName  + "=\(parameters.sortOrder)")
    }
}
