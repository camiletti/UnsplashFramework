//
//  JSONDecoder+Extensions.swift
//  UnsplashFramework
//
//  Created by Pablo Camiletti on 11/07/2021.
//  Copyright © 2021 Pablo Camiletti. All rights reserved.
//

extension JSONDecoder {

    static var unsplashDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return decoder
    }
}
