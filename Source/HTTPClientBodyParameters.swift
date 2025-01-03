//
// Copyright (c) 2020 Shakuro (https://shakuro.com/)
// Sergey Laschuk
//

import Alamofire
import Foundation

/// Sets appropriate value for 'Content-Type' header.
public enum HTTPClientBodyParameters: CustomStringConvertible, Sendable {

    /// formData; URLEncoding with destination of httpBody
    case httpBody(arrayBrakets: Bool, parameters: [String: any Any & Sendable])
    case json(parameters: any Any & Sendable)

    public var description: String {
        switch self {
        case .httpBody(let arrayBrakets, let parameters):
            return "HTTP body" + (arrayBrakets ? " [braketed]" : "") + " : \(parameters)"
        case .json(let parameters):
            return "JSON body : \(parameters)"
        }
    }

    internal func encode(intoRequest: URLRequest) throws -> URLRequest {
        switch self {
        case .httpBody(let arrayBrakets, let parameters):
            let arrayEncoding: URLEncoding.ArrayEncoding = arrayBrakets ? .brackets : .noBrackets
            let encoding = URLEncoding(destination: .httpBody, arrayEncoding: arrayEncoding)
            return try encoding.encode(intoRequest, with: parameters)
        case .json(let parameters):
            let encoding = JSONEncoding.default
            return try encoding.encode(intoRequest, withJSONObject: parameters)
        }
    }

}
