//
//  UNAPITester.swift
//  
//
//  Created by Pablo Camiletti on 12/08/2022.
//

import Foundation
import XCTest
@testable import UnsplashFramework

final class UNAPITester: UNAPI {

    // MARK: - Properties

    let expectedMethod: UNAPI.HTTPMethod

    let expectedEndpoint: Endpoint

    let expectedParameters: ParametersURLRepresentable?

    // MARK: - Life Cycle

    init(credentials: UNCredentials,
         urlSession: URLSession,
         expectedMethod: UNAPI.HTTPMethod,
         expectedEndpoint: Endpoint,
         expectedParameters: ParametersURLRepresentable?) {
        self.expectedMethod = expectedMethod
        self.expectedEndpoint = expectedEndpoint
        self.expectedParameters = expectedParameters
        super.init(credentials: credentials, urlSession: urlSession)
    }

    private override init(credentials: UNCredentials, urlSession: URLSession = URLSession(configuration: .default)) {
        fatalError("This method shouldn't be used for testing")
    }

    // MARK: - Mock overrides

    override func request<T>(_ method: UNAPI.HTTPMethod,
                             endpoint: Endpoint,
                             parameters: ParametersURLRepresentable?) async throws -> T where T : Decodable {
        XCTAssertEqual(method, expectedMethod)
        XCTAssertEqual(endpoint.path, expectedEndpoint.path)
        XCTAssertEqual(parameters?.asQueryItems(), expectedParameters?.asQueryItems())
        return try await super.request(method, endpoint: endpoint, parameters: parameters)
    }
}
