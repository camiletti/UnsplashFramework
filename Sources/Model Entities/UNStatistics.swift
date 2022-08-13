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

public enum UNStatisticsInterval: String, Codable {
    case days
}

/// Not thought to be used on its own, but as an abstraction
/// of different types of analytics.
public class UNStatistics: Codable {

    // MARK: - Declarations

    private enum CodingKeys: CodingKey {
        case downloads
        case views
    }

    public struct Info: Codable {

        // MARK: - Declarations

        private enum CodingKeys: String, CodingKey {
            case total
            case history = "historical"
        }

        public struct History: Codable {

            // MARK: - Declarations

            private enum CodingKeys: String, CodingKey {
                case amountOfChanges = "change"
                case interval = "resolution"
                case changes = "values"
            }

            public struct Change: Codable {

                // MARK: - Declarations

                private enum CodingKeys: String, CodingKey {
                    case date
                    case value
                }

                // MARK: - Properties

                /// The date that the snapshot represents
                public let date: Date

                /// The amount of times the `action` was performed, where:
                /// - `action` will be determined from the context in which `Info` is in (e.g. downloads/views/likes)
                public let value: Int

                private static let formatter: DateFormatter = {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    return formatter
                }()

                // MARK: - Life Cycle

                public init(from decoder: Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)

                    let dateString = try container.decode(String.self, forKey: .date)
                    guard let decodedDate = Self.formatter.date(from: dateString) else {
                        throw DecodingError.dataCorruptedError(forKey: .date,
                                                               in: container,
                                                               debugDescription: "Date format doesn't match expected yyyy-MM-dd. Instead received: \(dateString)")
                    }

                    date = decodedDate
                    value = try container.decode(Int.self, forKey: .value)
                }

                public func encode(to encoder: Encoder) throws {
                    var container = encoder.container(keyedBy: CodingKeys.self)

                    try container.encode(date, forKey: .date)
                    try container.encode(value, forKey: .value)
                }
            }

            // MARK: - Properties

            /// The total amount of changes recorded for the `action` in the specified time interval over the `item` life, where:
            /// - `actions` will be determined from the context in which `Info` is in (e.g. downloads/views/likes)
            /// - `item` will be determined from the context in which `Info` is in (e.g. photos/users)
            public let amountOfChanges: Int

            /// The time interval between each change (aka data points)
            public let interval: UNStatisticsInterval

            /// A snapshot in time of the `action`, where:
            /// - `action` will be determined from the context in which `Info` is in (e.g. downloads/views/likes)
            public let changes: [Change]
        }

        // MARK: - Properties

        /// The total amount of actions the item had, where:
        /// - `actions` will be determined from the context in which `Info` is in (e.g. downloads/views/likes)
        /// - `item` will be determined from the context in which `Info` is in (e.g. photos/users)
        public let total: Int

        /// How the `action` has changed overtime
        /// - `actions` will be determined from the context in which `Info` is in (e.g. downloads/views/likes)
        public let history: History
    }

    // MARK: - Properties

    /// The statistics regarding the downloads the photo had.
    public let downloads: Info

    /// The statistics regarding the views the photo had.
    public let views: Info

    // MARK: - Life Cycle

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        downloads = try container.decode(Info.self, forKey: .downloads)
        views = try container.decode(Info.self, forKey: .views)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(downloads, forKey: .downloads)
        try container.encode(views, forKey: .views)
    }
}
