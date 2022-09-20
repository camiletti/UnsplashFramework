//
//  UnsplashFramework
//
//  Copyright Pablo Camiletti
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

/// Holds all the information about a category.
public struct UNCategory: Decodable {

    // MARK: - Declarations

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case photoAmount = "photo_count"
        case apiLocations = "links"
    }

    // MARK: - Properties

    /// Unique identifier of the category.
    public var id: Int

    /// Title of the category.
    public var title: String?

    /// Number of photos the category has.
    public var photoAmount: Int

    /// API locations.
    public var apiLocations: UNCategoryAPILocations
}

// MARK: - Equatable
extension UNCategory: Equatable {
    /// Returns a Boolean value indicating whether the two categories represent the same category.
    ///
    /// Discussion: Two categories are considered to be the same if they represent
    /// the same category; that is, if they have the same id, regardless
    /// if the other variables are different.
    public static func == (lhs: UNCategory, rhs: UNCategory) -> Bool {
        lhs.id == rhs.id
    }

    /// Returns a Boolean value indicating whether two categories don't represent the same category.
    public static func != (lhs: UNCategory, rhs: UNCategory) -> Bool {
        !(lhs == rhs)
    }
}
