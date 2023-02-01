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

/// Client credentials necessary to query Unsplash.
public struct UNCredentials {

    // MARK: - Properties

    /// Unsplash Access Key.
    public let accessKey: String

    /// Unsplash Secret.
    public let secret: String

    /// The redirect URI that Unsplash should call when a user is authenticated in order to access their private information.
    /// The URI must be specified in the allow-list on the app's dashboard in Unsplash.
    /// https://unsplash.com/oauth/applications
    public let redirectAuthenticationURI: String?

    // MARK: - Life Cycle

    public init(accessKey: String, secret: String, redirectAuthenticationURI: String?) {
        self.accessKey = accessKey
        self.secret = secret
        self.redirectAuthenticationURI = redirectAuthenticationURI
    }
}
