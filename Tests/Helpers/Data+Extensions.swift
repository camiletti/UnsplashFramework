//
//  Data+Extensions.swift
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

extension Data {

    /// Extension to check if the data represents an image.
    /// Taken from: https://stackoverflow.com/a/45758208
    var isImageData: Bool {
        let array = withUnsafeBytes {
            [UInt8](UnsafeBufferPointer(start: $0, count: 10))
        }

        let intervals: [[UInt8]] =
        [
            [0x42, 0x4D], // bmp
            [0xFF, 0xD8, 0xFF], // jpg
            [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A], // png
            [0x00, 0x00, 0x00, 0x0C, 0x6A, 0x50, 0x20, 0x20], // jpeg2000
            [0x49, 0x49, 0x2A, 0x00], // tiff1
            [0x4D, 0x4D, 0x00, 0x2A] // tiff2
        ]

        for interval in intervals {
            var image = true
            for i in 0 ..< interval.count where array[i] != interval[i] {
                image = false
                break
            }

            if image {
                return true
            }
        }

        return false
    }
}
