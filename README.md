![UnsplashFramework-Light](https://raw.githubusercontent.com/camiletti/UnsplashFramework/master/UnsplashFrameworkLogo-Light.png#gh-light-mode-only)
![UnsplashFramework-Dark](https://raw.githubusercontent.com/camiletti/UnsplashFramework/master/UnsplashFrameworkLogo-Dark.png#gh-dark-mode-only)

<p align="center">
	<a href="https://github.com/camiletti/UnsplashFramework/actions/workflows/ci.yml"><img src="https://github.com/camiletti/UnsplashFramework/actions/workflows/ci.yml/badge.svg?event=push" /></a>
    <a href="#SPM"><img src="https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat" /></a>
	<a href="https://swiftpackageindex.com/camiletti/UnsplashFramework"><img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fcamiletti%2FUnsplashFramework%2Fbadge%3Ftype%3Dswift-versions" /></a>
	<a href="https://swiftpackageindex.com/camiletti/UnsplashFramework"><img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fcamiletti%2FUnsplashFramework%2Fbadge%3Ftype%3Dplatforms" /></a>
    <a href="#-license"><img src="https://img.shields.io/github/license/camiletti/UnsplashFramework" /></a>   
</p>


## 📷 Introduction
The idea behind this project is to make an easy-to-use, well tested and well documented client framework for Unsplash.
Please read Unsplash's [Guidelines & Credition](https://unsplash.com/documentation#guidelines--crediting) before using it.


## 🛠 Features
The plan is to achieve feature parity with Unsplash REST API

### Users
- [x] Get a user’s public profile
- [x] Get a user’s portfolio link
- [x] List a user’s photos
- [x] List a user’s liked photos
- [x] List a user’s collections
- [x] Get a user’s statistics

### Photos
- [x] List editorial photos
- [x] Get a photo
- [x] Get a random photo
- [x] Get a photo’s statistics
- [x] Track a photo download
- [x] Update a photo
- [x] Like a photo
- [x] Unlike a photo

### Search
- [x] Search photos
- [x] Search collections
- [x] Search user

### Collections
- [x] List collections
- [x] Get a collection
- [x] Get a collection’s photos
- [x] List a collection’s related collections
- [x] Create a new collection
- [x] Update an existing collection
- [x] Delete a collection
- [x] Add a photo to a collection
- [x] Remove a photo from a collection

### Topics
- [x] List topics
- [x] Get a topic
- [x] Get a topic’s photos

### Stats
- [x] Totals
- [x] Month

### Authentication
- [x] Public authentication
- [x] User authentication


## Requirement

- iOS 15.0+
- Xcode 15.0+


## ⬇️ Installation

### SPM

Add the following to your `Package` file:

```swift
dependencies: [
    .package(url: "https://github.com/camiletti/UnsplashFramework.git", from: "0.4.0")
]
```


## 🎛 Examples of use
```swift
import UnsplashFramework
```

### Credentials

Before doing any request, the Unsplash client credentials should be set. If you haven't registered yet, you can do so [here](https://unsplash.com/developers).

```swift
let credentials = UNCredentials(appID: "Your_AppID", secret: "Your_Secret"
let client = UNClient(with: credentials)
```


### Listing photos from a user


```swift
let photos = try await client.photos(fromUsername: "camiletti",
                                     page: 1,
                                     includeStats: true,
                                     sortingBy: .latest)
```


### User profiles


```swift
let profile = try await client.publicProfile(forUsername: "camiletti")
```


### Searching

```swift
// Searching photos
let photos = try await client.searchPhotos(query: "forest",
                                           page: 1,
                                           photosPerPage: 10,
                                           orderedBy: .relevance,
                                           orientation: .landscape)

// Searching collections
let collections = try await client.searchCollections(query: "jungle",
                                                     page: 1,
                                                     collectionsPerPage: 10)

// Searching for users
let users = try await client.searchUsers(query: "camiletti",
                                         page: 1,
                                         usersPerPage: 10)
```


## 📖 Documentation

[Full documentation here](https://swiftpackageindex.com/camiletti/UnsplashFramework/0.4.0/documentation/unsplashframework)


## 🦣 Contact

[@camiletti](https://mastodon.cloud/@camiletti)


## 📄 License

UnsplashFramework is under MIT license.

```
Copyright 2024 Pablo Camiletti

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is furnished
to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
