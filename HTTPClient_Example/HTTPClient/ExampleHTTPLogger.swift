//
//
//

import Alamofire
import Foundation
import HTTPClient_Framework

class ExampleHTTPLogger: HTTPClientLoggerFull {

    override func log(_ message: String) {
        print(message)
    }

}
