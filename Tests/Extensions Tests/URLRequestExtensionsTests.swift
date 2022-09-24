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

@testable import UnsplashFramework
import XCTest

final class URLSessionExtensionsTests: XCTestCase {

    // MARK: - Test request generation

    func testCreatingAPublicRequestForEveryEndpoint() {
        // Parameters
        let id = "abc"
        let credentials = UNCredentials(accessKey: "123", secret: "789")
        let headers: [UNAPI.Header] = [UNAPI.Header.acceptVersion,
                                       UNAPI.Header.authorization(accessKey: credentials.accessKey)]
        // The parameters chosen are a sample of typical parameters. The test will make sure
        // the URLSession extension is converting the parameters into a correct URL format.
        // Tests for each parameter type are tested independently in their own tests.
        let parameters = UNPhotoListParameters(pageNumber: 1,
                                               photosPerPage: 10,
                                               sorting: .popular)
        // Make sure all endpoint's `path` generate a valid URL.
        let endpoints: [Endpoint] = [.userPublicProfile(username: id),
                                     .userPortfolioLink(username: id),
                                     .userPhotos(username: id),
                                     .userLikedPhotos(username: id),
                                     .userCollections(username: id),
                                     .userStatistics(username: id),
                                     .editorialPhotosList,
                                     .photo(id: id),
                                     .randomPhoto,
                                     .photoStatistics(id: id),
                                     .trackPhotoDownload(id: id),
                                     .likePhoto(id: id),
                                     .photoSearch,
                                     .collectionSearch,
                                     .userSearch,
                                     .collections,
                                     .collection(id: id),
                                     .photosInCollection(id: id),
                                     .relatedCollections(id: id),
                                     .addPhotoToCollection(collectionID: id),
                                     .removePhotoToCollection(collectionID: id),
                                     .topicsList,
                                     .topic(idOrSlug: id),
                                     .photosOfTopic(idOrSlug: id),
                                     .unsplashTotalStats,
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
        URL(string: UNAPI.scheme + "://" + UNAPI.location + endpoint.path + "?" +
                UNPhotoListParameters.QueryParameterName.pageNumber + "=\(parameters.pageNumber!)&" +
                UNPhotoListParameters.QueryParameterName.photosPerPage + "=\(parameters.photosPerPage!)&" +
                UNPhotoListParameters.QueryParameterName.sorting + "=\(parameters.sorting!)")
    }
}
