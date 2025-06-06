//
//
//

import Alamofire
import Foundation
import HTTPClient_Framework

internal final class ExampleHTTPClient: HTTPClientProtocol {

    internal let httpClient: HTTPClient<ExampleAPIEndPoint>

    internal init() {
        self.httpClient = HTTPClient(name: "ExampleHTTPClient",
                                     configuration: nil,
                                     logger: HTTPClientLoggerFull(logAction: { print($0) }),
                                     commonHeaders: [])
    }

}
