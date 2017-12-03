//
//  UNImageRequesterSpy.swift
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


import XCTest
@testable import UnsplashFramework


typealias UNImageRequesterSpyClosure = (_ photo: UNPhoto, _ size: UNPhotoImageSize, _ dataImage: Data?, _ error: UNError?) -> Void


class UNImageRequesterSpy
{
    
    private let closure : UNImageRequesterSpyClosure
    
    
    init(with closure: @escaping UNImageRequesterSpyClosure)
    {
        self.closure = closure
    }
}


extension UNImageRequesterSpy: UNImageRequester
{
    func clientDidCompleteExclusiveImageRequest(for photo: UNPhoto,
                                                in size: UNPhotoImageSize,
                                                dataImage: Data?,
                                                error: UNError?)
    {
        self.closure(photo, size, dataImage, error)
    }
}
