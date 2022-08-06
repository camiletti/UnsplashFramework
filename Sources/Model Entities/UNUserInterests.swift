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

public struct UNUserInterests: Codable, Equatable {

    // MARK: - Declarations

    enum CodingKeys: String, CodingKey {
        case manuallySpecifiedTopicTitles = "custom"
        case inferredTopicTitles = "aggregated"
    }

    struct NestedTopicTileContainer: Codable {
        let title: String
    }

    // MARK: - Properties

    /// Titles of topics that the user has manually specified in their profile page.
    public let manuallySpecifiedTopicTitles: [String]

    /// Titles of topics that Unsplash has inferred based on user activity.
    public let inferredTopicTitles: [String]

    // MARK: - Life Cycle

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        manuallySpecifiedTopicTitles = (try container.decode([NestedTopicTileContainer].self, forKey: .manuallySpecifiedTopicTitles))
            .map { $0.title }
        inferredTopicTitles = try container.decode([NestedTopicTileContainer].self, forKey: .inferredTopicTitles)
            .map { $0.title }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UNUserInterests.CodingKeys.self)

        try container.encode(manuallySpecifiedTopicTitles.map { NestedTopicTileContainer(title: $0) }, forKey: .manuallySpecifiedTopicTitles)
        try container.encode(inferredTopicTitles.map { NestedTopicTileContainer(title: $0) }, forKey: .inferredTopicTitles)
    }
}
