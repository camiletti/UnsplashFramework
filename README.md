![UnsplashFramework](https://cdn.rawgit.com/camiletti/UnsplashFramework/master/UnsplashFramework.png)

<p align="center">
	<a href="https://travis-ci.org/camiletti/UnsplashFramework"><img src="https://travis-ci.org/camiletti/UnsplashFramework.svg?branch=master" /></a>
	<a href="#-documentation"><img src="https://cdn.rawgit.com/camiletti/UnsplashFramework/master/docs/badge.svg" /></a>
	<a href="https://cocoapods.org/pods/UnsplashFramework"><img src="https://img.shields.io/cocoapods/v/UnsplashFramework.svg" /></a>
	<a href="#carthage"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" /></a>
	<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift-4.0-orange.svg?style=flat" /></a>
	<a href="#-license"><img src="https://img.shields.io/cocoapods/l/UnsplashFramework.svg" /></a>
</p>


## 📷 Introduction
The idea behind this project is to make an easy-to-use, well tested and well documented client framework for Unsplash.

> Currently in early development stage 🍼


## 🛠 Plan
- [x] List photos
- [x] Search photos
- [x] Search collections
- [x] Fetching images
- [ ] List collections
- [ ] Search user
- [ ] Users


## Requirement

- iOS 10.3+
- XCode 9.1+


## ⬇️ Installation

### CocoaPods

Add the following to your `Podfile`:

```ruby
pod 'UnsplashFramework', '~> 0.1'
```

### Carthage

Add the following to your `Cartfile`:

```ogdl
github "camiletti/UnsplashFramework" ~> 0.1
```


## 🎛 Use
```swift
import UnsplashFramework
```

### Credentials

Before doing any request, Unsplash client credentials should be set. If you haven't registed yet, you can do so [here](https://unsplash.com/developers).

```swift
UNClient.shared.setAppID("Your_AppID", secret: "Your_Secret")
```


### Listing photos


```swift
UNClient.shared.listPhotos(page: 1,
                           photosPerPage: 10,
                           sortingBy: .popular)
    { (result) in

        switch result {
        case .success(let photos):
            photos.forEach({ (photo) in
                print("Photo with ID: \(photo.id) from user: \(photo.user.username) main color: \(photo.hexColor)")
            })

        case .failure(let error):
            print("Error: \(error.reason)")
    }
}
```


### Searching photos

```swift
UNClient.shared.searchPhotos(query: "Forest",
                             page: 1,
                             photosPerPage: 10,
                             collections: nil,
                             orientation: .landscape)
    { (result) in
        
        switch result {
        case .success(let searchResult):
        searchResult.photos.forEach({ (photo) in
            print("Photo with ID: \(photo.id) from user: \(photo.user.username) main color: \(photo.hexColor)")
        })
        
        case .failure(let error):
            print("Error: \(error.reason)")
        }
    }
```


### Fetching the image of a photo and setting it to an UIImageView

For better performance and network utilization, a UNPhoto holds all the information of a photo except the image. The image of the photo can be requested independently in 5 size (raw, full, regular, small and thumb). Using the following UIImageView function will take care of the network request and setting the image as soon as it is downloaded. The main color of the photo can be set as the background while the request is in progress.

```swift
let imageView = UIImageView()
imageView.backgroundColor = photo.color

imageView.setImage(from: photo, inSize: .small)
```


### Fetching the image of a photo

```swift
let imageView = UIImageView()

UNClient.shared.fetchImage(from: photo,
                           inSize: .full)
    { (result) in
    
    switch result
    {
    case .success(let imageResult):
        imageView.image = imageResult.image
        
    case .failure(let error):
        print("Error: \(error.reason)")
    }
}
```

## 📖 Documentation

[Full documentation here](http://htmlpreview.github.io/?https://github.com/camiletti/UnsplashFramework/blob/master/docs/Classes/UNClient.html)


## 🐦 Contact

[@camiletti_p](https://twitter.com/camiletti_p)


## 📄 License

UnsplashFramework is under MIT license.

```
Copyright 2017 Pablo Camiletti

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
