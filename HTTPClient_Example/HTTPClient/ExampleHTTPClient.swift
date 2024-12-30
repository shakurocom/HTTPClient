//
//
//

import Alamofire
import Foundation
import HTTPClient_Framework

internal final class ExampleHTTPClient: HTTPClientProtocol {

    internal let httpClient: HTTPClient

    internal init() {
        self.httpClient = HTTPClient(name: "ExampleHTTPClient",
                                     configuration: nil,
                                     logger: ExampleHTTPLogger(),
                                     commonHeaders: [])
    }

}
