//
//
//

import Alamofire
import Foundation
import HTTPClient_Framework

internal class ExampleHTTPClient: HTTPClient {

    internal init() {
        super.init(name: "ExampleHTTPClient", logger: ExampleHTTPLogger())
    }

    internal override func commonHeaders() -> [HTTPHeader] {
        return []
    }

}
