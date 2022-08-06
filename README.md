![UnsplashFramework](https://cdn.rawgit.com/camiletti/UnsplashFramework/master/UnsplashFramework.png)

<p align="center">
	<a href="https://travis-ci.org/camiletti/UnsplashFramework"><img src="https://travis-ci.org/camiletti/UnsplashFramework.svg?branch=master" /></a>
	<a href="#-documentation"><img src="https://cdn.rawgit.com/camiletti/UnsplashFramework/master/docs/badge.svg" /></a>
    <a href="#SPM"><img src="https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat" /></a>
	<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift-5.5-orange.svg?style=flat" /></a>
	<a href="#-license"><img src="https://img.shields.io/cocoapods/l/UnsplashFramework.svg" /></a>
</p>


## 📷 Introduction
The idea behind this project is to make an easy-to-use, well tested and well documented client framework for Unsplash.
Please read Unsplash's [Guidelines & Credition](https://unsplash.com/documentation#guidelines--crediting) before using it.

> Currently in early development stage 🍼


## 🛠 Features
The plan is to achieve feature parity with Unsplash REST API

### Users
- [x] Get a user’s public profile
- [ ] Get a user’s portfolio link
- [ ] List a user’s photos
- [ ] List a user’s liked photos
- [ ] List a user’s collections
- [ ] Get a user’s statistics

### Photos
- [x] List photos
- [ ] Get a photo
- [ ] Get a random photo
- [ ] Get a photo’s statistics
- [ ] Track a photo download
- [ ] Update a photo
- [ ] Like a photo
- [ ] Unlike a photo

### Search
- [x] Search photos
- [x] Search collections
- [x] Search user

### Collections
- [ ] List collections
- [ ] Get a collection
- [ ] Get a collection’s photos
- [ ] List a collection’s related collections
- [ ] Create a new collection
- [ ] Update an existing collection
- [ ] Delete a collection
- [ ] Add a photo to a collection
- [ ] Remove a photo from a collection

### Topics
- [ ] List topics
- [ ] Get a topic
- [ ] Get a topic’s photos

### Stats
- [ ] Totals
- [ ] Month


## Requirement

- iOS 15.0+
- Swift 5.6+
- XCode 13.0+


## ⬇️ Installation

### SPM

Add the following to your `Package` file:

```swift
dependencies: [
    .package(url: "https://github.com/camiletti/UnsplashFramework.git", .branch("master"))
]
```


## 🎛 Use
```swift
import UnsplashFramework
```

### Credentials

Before doing any request, the Unsplash client credentials should be set. If you haven't registered yet, you can do so [here](https://unsplash.com/developers).

```swift
let credentials = UNCredentials(appID: "Your_AppID", secret: "Your_Secret"
let client = UNClient(with: credentials)
```


### Listing photos


```swift
let photos = try await client.listPhotos(page: 1,
                                         photosPerPage: 1,
                                         sortingBy: .popular)
```


### Searching

```swift
// Searching photos
let photos = try await client.searchPhotos(query: "forest",
                                           page: 1,
                                           photosPerPage: 10,
                                           collections: [],
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

[Full documentation here](http://htmlpreview.github.io/?https://github.com/camiletti/UnsplashFramework/blob/master/docs/Classes/UNClient.html)


## 🐦 Contact

[@camiletti_p](https://twitter.com/camiletti_p)


## 📄 License

UnsplashFramework is under MIT license.

```
Copyright 2021 Pablo Camiletti

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
