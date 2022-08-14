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

public struct UNCameraDetails: Codable {

    // MARK: - Declarations

    enum CodingKeys: String, CodingKey {
        case brand = "make"
        case model
        case formattedName = "name"
        case exposureTime = "exposure_time"
        case aperture
        case focalLength = "focal_length"
        case iso
    }

    // MARK: - Properties

    /// The brand of the camera
    public let brand: String

    /// The model of the camera
    public let model: String

    /// Formatted (full) name of the brand plus model
    public let formattedName: String

    /// The time exposure used to take the photo
    public let exposureTime: String

    /// The lens aperture used to take the photo
    public let aperture: String

    /// The focal length used to take the photo
    public let focalLength: String

    /// The iso used to take the photo
    public let iso: Int
}
