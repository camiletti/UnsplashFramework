//
//  Closures.swift
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


public typealias UNPhotoListClosure = (_ result: UNResult<[UNPhoto]>) -> Void

public typealias UNPhotoSearchClosure      = (_ result: UNResult<UNSearchResult<UNPhoto>>)      -> Void
public typealias UNCollectionSearchClosure = (_ result: UNResult<UNSearchResult<UNCollection>>) -> Void
public typealias UNUserSearchClosure       = (_ result: UNResult<UNSearchResult<UNUser>>)       -> Void

public typealias UNImageFetchClosure = (_ result: UNResult<UNImageFetchResult>) -> Void

public typealias UNFetchDataImageClosure = (_ requestedPhoto : UNPhoto,
                                            _ requestedSize: UNPhotoImageSize,
                                            _ imageData: Data?,
                                            _ error: UNError?) -> Void
