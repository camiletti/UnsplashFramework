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

open class UNAPI {

    // MARK: - Properties

    private var credentials: UNCredentials

    private let urlSession: URLSession

    private var defaultHeaders: [RequestHeader] {
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
    ///   - location: The schema location at which the request should be directed.
    ///   - parameters: The parameters to use for the request.
    /// - Returns: The value for the requested type.
    @discardableResult
    func request<T: Decodable>(_ method: HTTPMethod,
                               endpoint: Endpoint,
                               at location: Host.Location,
                               parameters: ParametersURLRepresentable?) async throws -> (T, [ResponseHeader]) {

        let request = URLRequest.request(method,
                                         forEndpoint: endpoint,
                                         at: location,
                                         parameters: parameters,
                                         headers: defaultHeaders)

        let (data, response) = try await urlSession.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw UNError(reason: .unknownServerResponse)
        }

        guard !ResponseStatusCode.isError(code: httpResponse.statusCode) else {
            throw UNError(reason: .serverError(ResponseStatusCode(rawValue: httpResponse.statusCode)))
        }

        let headers = ResponseHeader.headers(from: httpResponse)

        let decoder = JSONDecoder.unsplashDecoder
        let value = try decoder.decode(T.self, from: data)

        return (value, headers)
    }

    /// Makes a REST request that expects no returned value
    ///
    /// - Parameters:
    ///   - method: The HTTP method to use.
    ///   - endpoint: The endpoint to call.
    ///   - parameters: The parameters to use for the request.
    func request(_ method: HTTPMethod,
                 endpoint: Endpoint,
                 at location: Host.Location,
                 parameters: ParametersURLRepresentable?) async throws -> [ResponseHeader] {

        let request = URLRequest.request(method,
                                         forEndpoint: endpoint,
                                         at: location,
                                         parameters: parameters,
                                         headers: defaultHeaders)

        let (_, response) = try await urlSession.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw UNError(reason: .unknownServerResponse)
        }

        if ResponseStatusCode.isError(code: httpResponse.statusCode) {
            throw UNError(reason: .serverError(ResponseStatusCode(rawValue: httpResponse.statusCode)))
        }

        return ResponseHeader.headers(from: httpResponse)
    }

    // MARK: - Authorization

    /// Creates an authorization URL. This URL should be opened in a web browser so the user can grant the
    /// requested permissions via Unsplash login. Once the user completes the authorization, Unsplash will call the completionURI.
    /// `handleAuthorizationCallback` should be called when this happens in order to process the result and obtain upgraded
    /// credentials with the requested scope.
    /// - Parameters:
    ///   - scope: A set with the desired access privileges.
    ///   - completionURI: The URI that Unsplash will call once the user accepts or denies the request.
    /// - Returns: An authorization URL that should be opened in a web browser.
    func authorizationURL(scope: Set<UserAuthorizationScope>, completionURI: String) -> URL {
        let parameters = AuthorizationAttemptParameters(credentials: credentials,
                                                        completionURI: completionURI,
                                                        scope: scope)
        let authorizationComponents = URLComponents(unsplashQuery: parameters.asQueryItems(),
                                                    endpoint: .authorization,
                                                    at: .web)
        return authorizationComponents.url!
    }

    /// Handles the callback URL that Unsplash returned after invoking `authorizationURL(scope:completionURI:)`
    /// - Parameters:
    ///   - url: The URL that Unsplash has called back with.
    ///   - completionURI: The same URI that has been used for `authorizationURL(scope:completionURI:)`
    func handleAuthorizationCallback(url: URL, completionURI: String) async throws {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        ///
        ///
        /// SEARCH WHY url.baseURL is nil
        ///
        ///
        let baseURL = url.absoluteString.components(separatedBy: "?").first
        guard baseURL == completionURI,
              let codeItem = components?.queryItems?.first(where: { $0.name == AuthorizationTokenParameters.QueryParameterName.code }),
              let code = codeItem.value else {
            throw UNError.init(reason: .incorrectAuthorizationURL)
        }

        let parameters = AuthorizationTokenParameters(credentials: credentials,
                                                      code: code)

        let response: (authorization: Authorization, _) = try await request(.post,
                                                                            endpoint: .authorizationToken,
                                                                            at: .web,
                                                                            parameters: parameters)

        credentials = UNCredentials(accessKey: response.authorization.accessToken,
                                    secret: credentials.secret)
    }
}
