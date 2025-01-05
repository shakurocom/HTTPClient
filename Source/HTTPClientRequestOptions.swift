//
//
//

import Alamofire

public struct HTTPClientRequestOptions<ParserType: HTTPClientParser, EndpointType: HTTPClientAPIEndPoint>: Sendable {

    public let endpoint: EndpointType
    public let method: Alamofire.HTTPMethod
    public let parser: ParserType
    public let urlQueryParameters: [String: any Any & Sendable]?
    public let urlQueryParametersAddArrayBrackets: Bool
    public let bodyParameters: HTTPClientBodyParameters?
    /// Headers will be applied in this order (overriding previous ones if key is the same):
    ///     default for http method -> HTTPClient.commonHeaders() -> RequestOptions.headers
    ///
    /// Default value contains "Accept": "application/json".
    ///
    /// Response will be validated against content type from "Accept" header. For common values see `HTTPClient.Constant`.
    public let headers: [Alamofire.HTTPHeader]
    public let authCredential: URLCredential?
    public let timeoutInterval: TimeInterval
    public let acceptableStatusCodes: Range<Int>

    public init(endpoint: EndpointType,
                method: Alamofire.HTTPMethod,
                parser: ParserType,
                urlQueryParameters: [String: any Any & Sendable]? = nil,
                urlQueryParametersAddArrayBrackets: Bool = false,
                bodyParameters: HTTPClientBodyParameters? = nil,
                headers: [Alamofire.HTTPHeader] = [HTTPClientContentType.applicationJSON.acceptHeader()],
                authCredential: URLCredential? = nil,
                timeoutInterval: TimeInterval = 60.0,
                acceptableStatusCodes: Range<Int> = 200..<300) {
        self.endpoint = endpoint
        self.method = method
        self.parser = parser
        self.urlQueryParameters = urlQueryParameters
        self.urlQueryParametersAddArrayBrackets = urlQueryParametersAddArrayBrackets
        self.bodyParameters = bodyParameters
        self.headers = headers
        self.authCredential = authCredential
        self.timeoutInterval = timeoutInterval
        self.acceptableStatusCodes = acceptableStatusCodes
    }

}
