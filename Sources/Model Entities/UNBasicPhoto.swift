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

import Foundation

public class UNBasicPhoto: Decodable, Identifiable {

    // MARK: - Declarations

    enum CodingKeys: String, CodingKey {
        case id
        case creationDate = "created_at"
        case updateDate = "updated_at"
        case blurHash = "blur_hash"
        case imageLinks = "urls"
    }

    /// Unique identifier of the photo.
    public let id: String

    /// Date the photo was created.
    public let creationDate: Date?

    /// Date the photo was updated.
    public let updateDate: Date?

    /// A very compact representation of an image placeholder
    /// which can be used to display a blurred preview before
    /// the real image loads. Learn more at https://blurha.sh
    public let blurHash: String

    /// Links to the different size of the photo.
    public let imageURLs: UNPhotoImageURLs

    // MARK: - Life Cycle

    init(id: String,
         creationDate: Date?,
         updateDate: Date?,
         blurHash: String,
         imageURLs: UNPhotoImageURLs) {
        self.id = id
        self.creationDate = creationDate
        self.updateDate = updateDate
        self.blurHash = blurHash
        self.imageURLs = imageURLs
    }

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameter decoder: Swift's decoder.
    /// - Throws: If a value that is non-optional is missing the function will throw.
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decode(String.self, forKey: .id)
        creationDate = try? values.decode(Date.self, forKey: .creationDate)
        updateDate = try? values.decode(Date.self, forKey: .updateDate)
        blurHash = try values.decode(String.self, forKey: .blurHash)
        imageURLs = try values.decode(UNPhotoImageURLs.self, forKey: .imageLinks)
    }
}
