//
//  UNAPI.swift
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
        case authorization(appID: String)

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

            case .authorization(let appID):
                return "Client-ID \(appID)"
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

    // MARK: - Life Cycle

    init(credentials: UNCredentials, urlSession: URLSession = URLSession(configuration: .default)) {
        self.credentials = credentials
        self.urlSession = urlSession
    }

    // MARK: - Actions

    /// Makes a REST request
    /// - Parameters:
    ///   - method: The HTTP method to use
    ///   - endpoint: The endpoint to call
    ///   - parameters: The parameters to use for the request
    ///   - completion: Completion closure to invoke once the request finished. This will always be called on the main thread
    /// - Returns: The URLSessionTask representing the request after being started
    @discardableResult
    func request<T: Decodable>(_ method: HTTPMethod,
                               endpoint: Endpoint,
                               parameters: ParametersURLRepresentable?,
                               completion: @escaping (Result<T, UNError>) -> Void) -> URLSessionTask {
        let decoder = JSONDecoder.unsplashDecoder

        // Add additional headers if needed
        let headers: [Header] = [.acceptVersion, .authorization(appID: credentials.appID)]

        let mainThreadCompletion: (Result<T, UNError>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }

        let request = URLRequest.publicRequest(method, forEndpoint: endpoint, parameters: parameters, headers: headers)
        let task = urlSession.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let unError = UNError.checkIfItIsAnError(response, and: error) {
                mainThreadCompletion(.failure(unError))
                return
            }

            guard let data = data,
                  !data.isEmpty else {
                mainThreadCompletion(.failure(UNError(reason: .noDataReceived)))
                return
            }

            do {
                let decodedData = try decoder.decode(T.self, from: data)
                mainThreadCompletion(.success(decodedData))
                return
            } catch {
                mainThreadCompletion(.failure(UNError(reason: .unableToParseDataCorrectly)))
                return
            }
        }

        task.resume()
        return task
    }
}
