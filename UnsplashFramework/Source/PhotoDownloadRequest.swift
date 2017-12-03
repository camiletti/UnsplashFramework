//
//  PhotoDownloadRequest.swift
//  UnsplashFramework
//
//  Copyright 2017 Pablo Camiletti
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


/// Use to track a request related to a photo in a specific size.
internal struct PhotoDownloadRequest
{
    /// The requested photo.
    internal var photo : UNPhoto
    
    /// The requested size of the photo.
    internal var size  : UNPhotoImageSize
}


extension PhotoDownloadRequest : Hashable
{
    /// The computed hash value for the request.
    var hashValue: Int
    {
        return (self.photo.id + "\(self.size)").hashValue
    }
}


extension PhotoDownloadRequest : Equatable
{
    /// Returns a Boolean value indicating whether the two requests are equal.
    static func ==(lhs: PhotoDownloadRequest, rhs: PhotoDownloadRequest) -> Bool
    {
        return  lhs.photo == rhs.photo &&
                lhs.size  == rhs.size
    }
    
    
    /// Returns a Boolean value indicating whether the two requests are not equal.
    static func !=(lhs: PhotoDownloadRequest, rhs: PhotoDownloadRequest) -> Bool
    {
        return  !(lhs == rhs)
    }
}
