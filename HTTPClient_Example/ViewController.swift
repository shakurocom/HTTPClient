//
// Copyright (c) 2021 Shakuro (https://shakuro.com/)
// Sergey Laschuk
//

import Alamofire
import HTTPClient_Framework
import UIKit

class ViewController: UIViewController {

    private var request: Request?
    private let client: HTTPClient = HTTPClient(name: "test", logger: ExampleHTTPLogger())

    override func viewDidLoad() {
        super.viewDidLoad()

        let requestOptions = HTTPClient.RequestOptions(
            endpoint: ExampleEndPoint.artworks,
            method: .get,
            parser: ExampleParser(),
            urlQueryParameters: ["page": 2,
                                 "limit": 10],
            bodyParameters: nil)
        request = client.sendRequest(options: requestOptions, completion: { result in
            print(result)
        })
        print(client.commonHeaders().debugDescription)
    }

}
