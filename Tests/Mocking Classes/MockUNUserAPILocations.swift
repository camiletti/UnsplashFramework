//
//  MockUNUserAPILocations.swift
//  MockUNUserAPILocations
//
//  Copyright 2021 Pablo Camiletti
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

extension UNUserAPILocations {

    static func mock(apiProfileURL: URL = URL(string: "https://api.unsplash.com/username")!,
                     apiPhotosURL: URL = URL(string: "https://api.unsplash.com/username")!,
                     apiLikesURL: URL = URL(string: "https://api.unsplash.com/username/likes")!,
                     apiPortfolioURL: URL = URL(string: "https://api.unsplash.com/username")!,
                     apiFollowingURL: URL? = URL(string: "https://api.unsplash.com/username/following")!,
                     apiFollowersURL: URL? = URL(string: "https://api.unsplash.com/username/followers")!,
                     externalProfileURL: URL = URL(string: "https://unsplash.com/username")!) -> UNUserAPILocations {
        UNUserAPILocations(apiProfileURL: apiProfileURL,
                           apiPhotosURL: apiPhotosURL,
                           apiLikesURL: apiLikesURL,
                           apiPortfolioURL: apiPortfolioURL,
                           apiFollowingURL: apiFollowingURL,
                           apiFollowersURL: apiFollowersURL,
                           externalProfileURL: externalProfileURL)
    }
}
