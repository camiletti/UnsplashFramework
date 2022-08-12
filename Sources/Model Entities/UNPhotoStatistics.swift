//
//  UNPhotoStatistics.swift
//  
//
//  Created by Pablo Camiletti on 10/08/2022.
//

import Foundation

/// The statistics of a given photo.
final public class UNPhotoStatistics: UNStatistics {

    // MARK: - Declarations

    private enum CodingKeys: CodingKey {
        case likes
    }

    // MARK: - Properties

    /// The statistics regarding the likes the photo had.
    public let likes: Info

    // MARK: - Life Cycle

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        likes = try container.decode(Info.self, forKey: .likes)
        try super.init(from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(likes, forKey: .likes)
        try super.encode(to: encoder)
    }
}
