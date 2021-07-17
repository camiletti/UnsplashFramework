//
//  ResponseStatusCode.swift
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

/// HTTP status codes
///
/// Discussion: Descriptions taken from https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
public enum ResponseStatusCode: Int {

    // MARK: - Success

    /// Standard response for successful HTTP requests.
    case success = 200
    /// The request has been fulfilled, resulting in the creation of a new resource.
    case created = 201
    /// The request has been accepted for processing, but the processing has not been completed.
    case accepted = 202
    /// The server is a transforming proxy (e.g. a Web accelerator) that received a 200 OK from its origin, but is returning a modified version of the origin's response.
    case nonAuthoritativeInformation = 203
    /// The server successfully processed the request and is not returning any content.
    case noContent = 204
    /// The server successfully processed the request, but is not returning any content.
    case resetContent = 205

    // MARK: - Client errors
    /// The server cannot or will not process the request due to an apparent client error.
    case badRequest = 400
    /// Similar to 403 Forbidden, but specifically for use when authentication is required and has failed or has not yet been provided.
    case unauthorized = 401
    /// The request was valid, but the server is refusing action.
    case forbidden = 403
    /// The requested resource could not be found but may be available in the future.
    case notFound = 404
    /// A request method is not supported for the requested resource.
    case methodNotAllowed = 405
    /// The requested resource is capable of generating only content not acceptable according to the Accept headers sent in the request.
    case notAcceptable = 406
    /// The server timed out waiting for the request.
    case requestTimeout = 408
    /// Indicates that the request could not be processed because of conflict in the request.
    case conflict = 409
    /// Indicates that the resource requested is no longer available and will not be available again.
    case gone = 410
    /// The request did not specify the length of its content, which is required by the requested resource.
    case lengthRequired = 411
    /// The server does not meet one of the preconditions that the requester put on the request.
    case preconditionFailed = 412
    /// The request is larger than the server is willing or able to process.
    case payloadTooLarge = 413
    /// The URI provided was too long for the server to process.
    case URITooLong = 414
    /// The request entity has a media type which the server or resource does not support.
    case unsupportedMediaType = 415
    /// The client has asked for a portion of the file (byte serving), but the server cannot supply that portion.
    case rangeNotSatisfiable = 416
    /// The server cannot meet the requirements of the Expect request-header field.
    case expectationFailed = 417
    /// This code was defined in 1998 as one of the traditional IETF April Fools' jokes.
    case IAMATeapot = 418
    /// The request was directed at a server that is not able to produce a response.
    case misdirectedRequest = 421
    /// The request was well-formed but was unable to be followed due to semantic errors.
    case unprocessableEntity = 422
    /// The resource that is being accessed is locked.
    case locked = 423
    /// The request failed due to failure of a previous request.
    case failedDependency = 424
    /// The client should switch to a different protocol such as TLS/1.0, given in the Upgrade header field.
    case upgradeRequired = 426
    /// The origin server requires the request to be conditional.
    case preconditionRequired = 428
    /// The user has sent too many requests in a given amount of time.
    case tooManyRequests = 429
    /// The server is unwilling to process the request because either an individual header field, or all the header fields collectively, are too large.
    case requestHeaderFieldsTooLarge = 431
    /// A server operator has received a legal demand to deny access to a resource or to a set of resources that includes the requested resource.
    case unavailableForLegalReasons = 451

    // MARK: - Server errors

    ///  A generic error message, given when an unexpected condition was encountered and no more specific message is suitable.
    case internalServerError = 500
    /// The server either does not recognize the request method, or it lacks the ability to fulfil the request.
    case notImplemented = 501
    /// The server was acting as a gateway or proxy and received an invalid response from the upstream server.
    case badGateway = 502
    /// The server is currently unavailable (because it is overloaded or down for maintenance).
    case serviceUnavailable = 503
    /// The server was acting as a gateway or proxy and did not receive a timely response from the upstream server.
    case gatewayTimeout = 504
    /// The server does not support the HTTP protocol version used in the request.
    case HTTPVersionNotSupported = 505
    /// Transparent content negotiation for the request results in a circular reference.
    case variantAlsoNegotiates = 506
    /// The server is unable to store the representation needed to complete the request.
    case insufficientStorage = 507
    /// The server detected an infinite loop while processing the request.
    case loopDetected = 508
    /// Further extensions to the request are required for the server to fulfil it.
    case notExtended = 509
    /// The client needs to authenticate to gain network access.
    case networkAuthenticationRequired = 511
}
