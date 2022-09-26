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
import Metal

open class UNAPI {

    // MARK: - Declarations

    /// HTTP accepted verbs, as described at https://unsplash.com/documentation#http-verbs
    enum HTTPMethod: String {
        /// Method for retrieving resources.
        case get = "GET"
        /// Method for creating resources.
        case post = "POST"
        /// Method for updating resources.
        case put = "PUT"
        /// Method for deleting resources.
        case delete = "DELETE"
    }

    /// Accepted headers as described at https://unsplash.com/documentation
    enum Header {
        case acceptVersion
        case authorization(accessKey: String)

        var fieldName: String {
            switch self {
            case .acceptVersion:
                return "Accept-Version"

            case .authorization:
                return "Authorization"
            }
        }

        var fieldValue: String {
            switch self {
            case .acceptVersion:
                return "v1"

            case .authorization(let accessKey):
                return "Client-ID \(accessKey)"
            }
        }
    }

    /// Scheme as described at https://unsplash.com/documentation#location
    static let scheme = "https"

    /// Location as described at https://unsplash.com/documentation#location
    static let location = "api.unsplash.com"

    // MARK: - Properties

    private let credentials: UNCredentials

    private let urlSession: URLSession

    private var defaultHeaders: [Header] {
        [.acceptVersion, .authorization(accessKey: credentials.accessKey)]
    }

    // MARK: - Life Cycle

    init(credentials: UNCredentials, urlSession: URLSession = URLSession(configuration: .default)) {
        self.credentials = credentials
        self.urlSession = urlSession
    }

    // MARK: - Actions

    /// Makes a REST request that expects a returned value
    ///
    /// - Parameters:
    ///   - method: The HTTP method to use.
    ///   - endpoint: The endpoint to call.
    ///   - parameters: The parameters to use for the request.
    /// - Returns: The value for the requested type.
    @discardableResult
    func request<T: Decodable>(_ method: HTTPMethod,
                               endpoint: Endpoint,
                               parameters: ParametersURLRepresentable?) async throws -> T {

        let request = URLRequest.publicRequest(method, forEndpoint: endpoint, parameters: parameters, headers: defaultHeaders)

        let (data, response) = try await urlSession.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw UNError(reason: .unknownServerResponse)
        }

        guard !ResponseStatusCode.isError(code: httpResponse.statusCode) else {
            throw UNError(reason: .serverError(ResponseStatusCode(rawValue: httpResponse.statusCode)))
        }

        let decoder = JSONDecoder.unsplashDecoder
        return try decoder.decode(T.self, from: data)
    }

    /// Makes a REST request that expects no returned value
    ///
    /// - Parameters:
    ///   - method: The HTTP method to use.
    ///   - endpoint: The endpoint to call.
    ///   - parameters: The parameters to use for the request.
    func request(_ method: HTTPMethod,
                 endpoint: Endpoint,
                 parameters: ParametersURLRepresentable?) async throws {

        let request = URLRequest.publicRequest(method, forEndpoint: endpoint, parameters: parameters, headers: defaultHeaders)

        let (_, response) = try await urlSession.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw UNError(reason: .unknownServerResponse)
        }

        if ResponseStatusCode.isError(code: httpResponse.statusCode) {
            throw UNError(reason: .serverError(ResponseStatusCode(rawValue: httpResponse.statusCode)))
        }
    }
}
