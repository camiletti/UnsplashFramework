//
//  QueryManager.swift
//  UnsplashFramework
//
//  Copyright 2021 Pablo Camiletti
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

class QueryManager {

    // MARK: - Properties

    /// Session used for querying Unsplash.
    private let api: UNAPI

    // MARK: - Life Cycle

    /// Creates a client with the specified credentials.
    ///
    /// - Parameters:
    ///   - credentials: The Unsplash client credentials.
    init(api: UNAPI) {
        self.api = api
    }

    /// Get a single page from the list of all photos.
    ///
    /// - Parameters:
    ///   - parameters: The parameters.
    ///   - completion: The completion handler that will be called with the results (Executed on the main thread).
    func listPhotos(with parameters: UNPhotoListParameters,
                    completion: @escaping UNPhotoListClosure) {
        api.request(.get,
                    endpoint: .photos,
                    parameters: parameters,
                    completion: completion)
    }

    /// Makes a query to Unsplash.
    ///
    /// - Parameters:
    ///   - searchType: The type of search to perform.
    ///   - parameters: Parameters to narrow the search.
    ///   - completion: The completion handler that will be called with the results (executed on the main thread).
    func search<T>(_ searchType: SearchType,
                   with parameters: ParametersURLRepresentable,
                   completion: @escaping (Result<UNSearchResult<T>, UNError>) -> Void) {
        api.request(.get,
                    endpoint: searchType.endpoint,
                    parameters: parameters,
                    completion: completion)
    }
}
