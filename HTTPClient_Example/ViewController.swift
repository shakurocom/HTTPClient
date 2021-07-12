//
// Copyright (c) 2021 Shakuro (https://shakuro.com/)
// Sergey Laschuk
//

import UIKit
import HTTPClient_Framework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let client = HTTPClient(name: "test") // TODO: make something useful
        print(client.commonHeaders().debugDescription)
    }

}
