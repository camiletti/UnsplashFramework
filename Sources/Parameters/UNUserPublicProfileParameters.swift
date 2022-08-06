//
//  UNUserPublicProfileParameters.swift
//  
//
//  Created by Pablo Camiletti on 06/08/2022.
//

import Foundation

/// The parameters' names and values that can be passed to fetch a user's public profile.
struct UNUserPublicProfileParameters {

    // MARK: - Declarations

    enum QueryParameterName {
        /// The user’s username. Required.
        static let username = "username"
    }

    // MARK: - Properties

    /// The user’s username. Required.
    let username: String
}

// MARK: - ParametersURLRepresentable
extension UNUserPublicProfileParameters: ParametersURLRepresentable {

    func asQueryItems() -> [URLQueryItem] {
        [URLQueryItem(name: QueryParameterName.username,
                      value: "\(username)")
        ]
    }
}
