//
//  MockUNUser.swift
//  MockUNUser
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

extension UNUser {

    static func mock(id: String = "A",
                     username: String = "username",
                     name: String? = "name",
                     firstName: String? = "firstName",
                     lastName: String? = "lastName",
                     twitterUsername: String? = "twitterUsername",
                     portfolioURL: URL? = URL(string: "https://unsplash.com/username"),
                     bio: String? = "A bio",
                     location: String? = "London",
                     totalLikes: Int = 1,
                     totalPhotos: Int = 1,
                     totalCollections: Int = 1,
                     profileImageLinks: UNProfileImageLinks = .mock(),
                     apiLocations: UNUserAPILocations = .mock()) -> UNUser {
        UNUser(id: id,
               username: username,
               name: name,
               firstName: firstName,
               lastName: lastName,
               twitterUsername: twitterUsername,
               portfolioURL: portfolioURL,
               bio: bio,
               location: location,
               totalLikes: totalLikes,
               totalPhotos: totalPhotos,
               totalCollections: totalCollections,
               profileImageLinks: profileImageLinks,
               apiLocations: apiLocations)
    }
}
