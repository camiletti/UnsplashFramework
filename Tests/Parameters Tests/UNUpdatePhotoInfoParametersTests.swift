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

final class UNUpdatePhotoInfoParametersTests: XCTestCase {

    func testAsQueryItemsWithoutOptionalProperties() {
        let expectedQueryItemsAmount = 0

        let parameters = UNUpdatePhotoInfoParameters(description: nil,
                                                     showsOnProfile: nil,
                                                     tags: nil,
                                                     location: nil,
                                                     cameraDetails: nil)

        let queryItems = parameters.asQueryItems()

        XCTAssertEqual(queryItems.count, expectedQueryItemsAmount)
    }

    func testAsQueryItemsWithOptionalProperties() {
        let expectedQueryItemsAmount = 14
        let expectedDescription = "A description"
        let expectedShowsOnProfile = true
        let expectedTags = ["Tag A", "Tag B"]
        let expectedLocation = DemoData.location
        let expectedCameraDetails = DemoData.cameraDetails

        let parameters = UNUpdatePhotoInfoParameters(description: expectedDescription,
                                                     showsOnProfile: expectedShowsOnProfile,
                                                     tags: expectedTags,
                                                     location: expectedLocation,
                                                     cameraDetails: expectedCameraDetails)

        let queryItems = parameters.asQueryItems()

        XCTAssertEqual(queryItems.count, expectedQueryItemsAmount)

        let descriptionValue = queryItems
            .first(where: { $0.name == UNUpdatePhotoInfoParameters.QueryParameterName.description })?
            .value
        XCTAssertEqual(descriptionValue, expectedDescription)

        let showsOnProfileValue = queryItems
            .first(where: { $0.name == UNUpdatePhotoInfoParameters.QueryParameterName.showsOnProfile })?
            .value
        XCTAssertEqual(showsOnProfileValue, "\(expectedShowsOnProfile)")

        let tagsValue = queryItems
            .first(where: { $0.name == UNUpdatePhotoInfoParameters.QueryParameterName.tags })?
            .value
        XCTAssertEqual(tagsValue, expectedTags.joined(separator: ","))

        // Location

        let locationFullNameValue = queryItems
            .first(where: { $0.name == UNUpdatePhotoInfoParameters.QueryParameterName.locationFullName })?
            .value
        XCTAssertEqual(locationFullNameValue, expectedLocation.name)

        let cityValue = queryItems
            .first(where: { $0.name == UNUpdatePhotoInfoParameters.QueryParameterName.city })?
            .value
        XCTAssertEqual(cityValue, expectedLocation.city)

        let countryValue = queryItems
            .first(where: { $0.name == UNUpdatePhotoInfoParameters.QueryParameterName.country })?
            .value
        XCTAssertEqual(countryValue, expectedLocation.country)

        let latitudeValue = queryItems
            .first(where: { $0.name == UNUpdatePhotoInfoParameters.QueryParameterName.latitude })?
            .value
        XCTAssertEqual(latitudeValue, String(describing: expectedLocation.coordinates!.latitude))

        let longitudeValue = queryItems
            .first(where: { $0.name == UNUpdatePhotoInfoParameters.QueryParameterName.longitude })?
            .value
        XCTAssertEqual(longitudeValue, String(describing: expectedLocation.coordinates!.longitude))

        // Camera Details

        let cameraBrandValue = queryItems
            .first(where: { $0.name == UNUpdatePhotoInfoParameters.QueryParameterName.cameraBrand })?
            .value
        XCTAssertEqual(cameraBrandValue, expectedCameraDetails.brand)

        let cameraModelValue = queryItems
            .first(where: { $0.name == UNUpdatePhotoInfoParameters.QueryParameterName.cameraModel })?
            .value
        XCTAssertEqual(cameraModelValue, expectedCameraDetails.model)

        let exposureTimeValue = queryItems
            .first(where: { $0.name == UNUpdatePhotoInfoParameters.QueryParameterName.exposureTime })?
            .value
        XCTAssertEqual(exposureTimeValue, expectedCameraDetails.exposureTime)

        let apertureValue = queryItems
            .first(where: { $0.name == UNUpdatePhotoInfoParameters.QueryParameterName.aperture })?
            .value
        XCTAssertEqual(apertureValue, expectedCameraDetails.aperture)

        let focalLengthValue = queryItems
            .first(where: { $0.name == UNUpdatePhotoInfoParameters.QueryParameterName.focalLength })?
            .value
        XCTAssertEqual(focalLengthValue, expectedCameraDetails.focalLength)

        let isoValue = queryItems
            .first(where: { $0.name == UNUpdatePhotoInfoParameters.QueryParameterName.iso })?
            .value
        XCTAssertEqual(isoValue, String(describing: expectedCameraDetails.iso))
    }

}
