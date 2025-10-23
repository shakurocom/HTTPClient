//
// Copyright (c) 2019 Shakuro (https://shakuro.com/)
// Sergey Laschuk
//

import Alamofire
import Foundation

public protocol HTTPClientLogger: Sendable {

    /// Request was formed with provided options and headers.
    /// Called before adding validator/serializers to said request and starting it.
    func clientDidCreateRequest<ParserType: HTTPClientParser, EndpointType>(
        requestOptions: HTTPClientRequestOptions<ParserType, EndpointType>,
        resolvedHeaders: Alamofire.HTTPHeaders)

    /// Called before parser is applied to response.
    func clientDidReceiveResponse<ParserType: HTTPClientParser, EndpointType>(
        requestOptions: HTTPClientRequestOptions<ParserType, EndpointType>,
        request: URLRequest?,
        response: HTTPURLResponse?,
        responseData: Data?,
        responseError: Error?)

    /// Request is marked as cancelled. no parsing will be done.
    func requestWasCancelled<ParserType: HTTPClientParser, EndpointType>(
        requestOptions: HTTPClientRequestOptions<ParserType, EndpointType>,
        request: URLRequest?,
        response: HTTPURLResponse?,
        responseData: Data?)

    /// `parseForError()` returned error.
    func parserDidFindError<ParserType: HTTPClientParser, EndpointType>(
        requestOptions: HTTPClientRequestOptions<ParserType, EndpointType>,
        request: URLRequest?,
        response: HTTPURLResponse?,
        responseData: Data?,
        parsedError: Swift.Error)

    /// Some network error happened, that was not handled by parser directly.
    func clientDidEncounterNetworkError<ParserType: HTTPClientParser, EndpointType>(
        requestOptions: HTTPClientRequestOptions<ParserType, EndpointType>,
        request: URLRequest?,
        response: HTTPURLResponse?,
        responseData: Data?,
        networkError: Swift.Error)

    /// Error during serialization of response data (before parsing)
    func clientDidEncounterSerializationError<ParserType: HTTPClientParser, EndpointType>(
        requestOptions: HTTPClientRequestOptions<ParserType, EndpointType>,
        request: URLRequest?,
        response: HTTPURLResponse?,
        responseData: Data?,
        serializationError: Swift.Error)

    /// Error during parsing of serialized data
    func clientDidEncounterParseError<ParserType: HTTPClientParser, EndpointType>(
        requestOptions: HTTPClientRequestOptions<ParserType, EndpointType>,
        request: URLRequest?,
        response: HTTPURLResponse?,
        responseData: Data?,
        parseError: Swift.Error)

}

public final class HTTPClientLoggerNone: HTTPClientLogger {

    public init() {}

    public func clientDidCreateRequest<ParserType: HTTPClientParser, EndpointType>(
        requestOptions: HTTPClientRequestOptions<ParserType, EndpointType>,
        resolvedHeaders: Alamofire.HTTPHeaders) { }

    public func clientDidReceiveResponse<ParserType: HTTPClientParser, EndpointType>(
        requestOptions: HTTPClientRequestOptions<ParserType, EndpointType>,
        request: URLRequest?,
        response: HTTPURLResponse?,
        responseData: Data?,
        responseError: Error?) {}

    public func requestWasCancelled<ParserType: HTTPClientParser, EndpointType>(
        requestOptions: HTTPClientRequestOptions<ParserType, EndpointType>,
        request: URLRequest?,
        response: HTTPURLResponse?,
        responseData: Data?) {}

    public func parserDidFindError<ParserType: HTTPClientParser, EndpointType>(
        requestOptions: HTTPClientRequestOptions<ParserType, EndpointType>,
        request: URLRequest?,
        response: HTTPURLResponse?,
        responseData: Data?,
        parsedError: Swift.Error) {}

    public func clientDidEncounterNetworkError<ParserType: HTTPClientParser, EndpointType>(
        requestOptions: HTTPClientRequestOptions<ParserType, EndpointType>,
        request: URLRequest?,
        response: HTTPURLResponse?,
        responseData: Data?,
        networkError: Swift.Error) {}

    public func clientDidEncounterSerializationError<ParserType: HTTPClientParser, EndpointType>(
        requestOptions: HTTPClientRequestOptions<ParserType, EndpointType>,
        request: URLRequest?,
        response: HTTPURLResponse?,
        responseData: Data?,
        serializationError: Swift.Error) {}

    public func clientDidEncounterParseError<ParserType: HTTPClientParser, EndpointType>(
        requestOptions: HTTPClientRequestOptions<ParserType, EndpointType>,
        request: URLRequest?,
        response: HTTPURLResponse?,
        responseData: Data?,
        parseError: Swift.Error) {}

}

/// Full logger, intended for subclassing to provide actual method to output logs.
public final class HTTPClientLoggerFull {

    private let tab: String
    private let parametersToCensor: [String]
    private let censoredValue: String
    private let logAction: @Sendable (_ message: String) -> Void

    /// - parameter tab: value used for indentation in multiline messages.
    ///         Default value is `    ` (4 spaces).
    /// - parameter parametersToCensor: parameters with this names will be substituted with `censoredValue` when being put into log.
    ///         Will be checked among headers, root parameters from body/query and authCredential.
    ///         Default value is `[]`
    /// - parameter censoredValue: value with which censored parameters will be substituted.
    ///         Default value is `xxxxxx`.
    public init(tab: String = "    ",
                parametersToCensor: [String] = [],
                censoredValue: String = "xxxxxx",
                logAction: @escaping @Sendable (_ message: String) -> Void) {
        self.tab = tab
        self.parametersToCensor = parametersToCensor
        self.censoredValue = censoredValue
        self.logAction = logAction
    }

    private func censorParameters(_ parameters: [String: any Any & Sendable]) -> [String: any Any & Sendable] {
        var censoredParameters = parameters
        for bannedParam in parametersToCensor where censoredParameters[bannedParam] != nil {
            censoredParameters[bannedParam] = censoredValue
        }
        return censoredParameters
    }

    public func generateResponseDataDebugDescription(_ responseData: Data?) -> String? {
        guard let data = responseData, !data.isEmpty else {
            return nil
        }
        let debugDescription: String
        if let responseDataString = String(data: data, encoding: .utf8) {
            debugDescription = responseDataString
        } else {
            debugDescription = "\(data)"
        }
        return debugDescription
    }

}

extension HTTPClientLoggerFull: HTTPClientLogger {

    public func clientDidCreateRequest<ParserType: HTTPClientParser, EndpointType>(
        requestOptions: HTTPClientRequestOptions<ParserType, EndpointType>,
        resolvedHeaders: HTTPHeaders) {
            var requestDescription = "Request: "
            requestDescription.append("\n\(tab)url: \(requestOptions.endpoint.urlString())")
            requestDescription.append("\n\(tab)timeoutInterval: \(requestOptions.timeoutInterval)")
            requestDescription.append("\n\(tab)method: \(requestOptions.method)")
            requestDescription.append("\n\(tab)allHTTPHeaderFields: \(resolvedHeaders)")
            if let urlQueryParameters = requestOptions.urlQueryParameters {
                let brakets = requestOptions.urlQueryParametersAddArrayBrackets
                requestDescription.append("\n\(tab)queyParameters (array brakets: \(brakets)): \(censorParameters(urlQueryParameters))")
            }
            if var bodyParameters = requestOptions.bodyParameters {
                switch bodyParameters {
                case .httpBody(let arrayBrakets, let parameters):
                    bodyParameters = .httpBody(arrayBrakets: arrayBrakets, parameters: censorParameters(parameters))
                case .json(let parameters):
                    if let typedParameters = parameters as? [String: any Any & Sendable] {
                        bodyParameters = .json(parameters: censorParameters(typedParameters))
                    } else {
                        bodyParameters = .json(parameters: parameters)
                    }
                case .httpBodyPlainString(_):
                    break
                }
                requestDescription.append("\n\(tab)parameters: \(bodyParameters)")
            }
            if let authCredentialActual = requestOptions.authCredential {
                let credentialForLog = URLCredential(user: censoredValue,
                                                     password: censoredValue,
                                                     persistence: authCredentialActual.persistence)
                requestDescription.append("\n\(tab)authCredential: \(credentialForLog)")
            }

            logAction(requestDescription)
        }

    public func clientDidReceiveResponse<ParserType: HTTPClientParser, EndpointType>(
        requestOptions: HTTPClientRequestOptions<ParserType, EndpointType>,
        request: URLRequest?,
        response: HTTPURLResponse?,
        responseData: Data?,
        responseError: Error?) {
            let codeString: String
            if let statusCode = response?.statusCode {
                codeString = "\(statusCode)"
            } else {
                codeString = "unknown"
            }
            let responseHeaderDescription = response?.allHeaderFields.description ?? "No Response Header"
            let responseDataDescription: String
            if let responseRawData = responseData, !responseRawData.isEmpty,
               let responseDataDescriptionActual = generateResponseDataDebugDescription(responseRawData) {
                responseDataDescription = responseDataDescriptionActual
            } else {
                responseDataDescription = "No Response Data"
            }
            let errorDescription: String
            if let error = responseError {
                errorDescription = "\(error)"
            } else {
                errorDescription = "No Error"
            }

            var responseDescription = "Response:"
            responseDescription.append("\n\(tab)url: \(requestOptions.endpoint.urlString())")
            responseDescription.append("\n\(tab)status code: \(codeString)")
            responseDescription.append("\n\(tab)error: \(errorDescription)")
            responseDescription.append("\n\(tab)headers:\n\(responseHeaderDescription)")
            responseDescription.append("\n\(tab)data:\n\(responseDataDescription)")

            logAction(responseDescription)
        }

    public func requestWasCancelled<ParserType: HTTPClientParser, EndpointType>(
        requestOptions: HTTPClientRequestOptions<ParserType, EndpointType>,
        request: URLRequest?,
        response: HTTPURLResponse?,
        responseData: Data?) {
            // handled by more generic clientDidReceiveResponse()
        }

    public func parserDidFindError<ParserType: HTTPClientParser, EndpointType>(
        requestOptions: HTTPClientRequestOptions<ParserType, EndpointType>,
        request: URLRequest?,
        response: HTTPURLResponse?,
        responseData: Data?,
        parsedError: Error) {
        // handled by more generic clientDidReceiveResponse()
    }

    public func clientDidEncounterNetworkError<ParserType: HTTPClientParser, EndpointType>(
        requestOptions: HTTPClientRequestOptions<ParserType, EndpointType>,
        request: URLRequest?,
        response: HTTPURLResponse?,
        responseData: Data?,
        networkError: Error) {
        // handled by more generic clientDidReceiveResponse()
    }

    public func clientDidEncounterSerializationError<ParserType: HTTPClientParser, EndpointType>(
        requestOptions: HTTPClientRequestOptions<ParserType, EndpointType>,
        request: URLRequest?,
        response: HTTPURLResponse?,
        responseData: Data?,
        serializationError: Error) {
            // usually handled by parser itself
        }

    public func clientDidEncounterParseError<ParserType: HTTPClientParser, EndpointType>(
        requestOptions: HTTPClientRequestOptions<ParserType, EndpointType>,
        request: URLRequest?,
        response: HTTPURLResponse?,
        responseData: Data?,
        parseError: Error) {
            // usually handled by parser itself
        }

}
