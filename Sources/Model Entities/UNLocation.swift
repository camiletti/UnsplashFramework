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

import CoreLocation
import Foundation

public struct UNLocation: Codable {

    // MARK: - Declarations

    enum CodingKeys: String, CodingKey {
        case title
        case name
        case city
        case country
        case coordinates = "position"
    }

    // MARK: - Properties

    /// The title of the location
    public let title: String

    /// The name of the location
    public let name: String

    /// The city of the location
    public let city: String

    /// The country of the location
    public let country: String

    /// The coordinates of the location
    public let coordinates: CLLocationCoordinate2D?

    // MARK: - Life Cycle

    public init(title: String, name: String, city: String, country: String, coordinates: CLLocationCoordinate2D? = nil) {
        self.title = title
        self.name = name
        self.city = city
        self.country = country
        self.coordinates = coordinates
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        title = try container.decode(String.self, forKey: .title)
        name = try container.decode(String.self, forKey: .name)
        city = try container.decode(String.self, forKey: .city)
        country = try container.decode(String.self, forKey: .country)
        coordinates = try? container.decode(CLLocationCoordinate2D.self, forKey: .coordinates)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(title, forKey: .title)
        try container.encode(name, forKey: .name)
        try container.encode(city, forKey: .city)
        try container.encode(country, forKey: .country)
        try container.encodeIfPresent(coordinates, forKey: .coordinates)
    }
}
