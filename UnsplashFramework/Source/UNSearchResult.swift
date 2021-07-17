//
//  UNSearchResult.swift
//  UnsplashFramework
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

/// Holds the result returned from Unsplash for a given search.
public struct UNSearchResult<Element: Decodable>: Decodable {

    // MARK: - Declarations

    enum CodingKeys: String, CodingKey {
        case totalElements = "total"
        case totalPages = "total_pages"
        case elements = "results"
    }

    // MARK: - Properties

    /// The total amount of elements found for the given search.
    public let totalElements: Int

    /// The total number of pages of elements found for the given search.
    public let totalPages: Int

    /// The elements contained in the requested page.
    public let elements: [Element]
}
