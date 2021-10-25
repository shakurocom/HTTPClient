//
//
//

import Foundation
import HTTPClient_Framework

struct ExampleAPIEndPoint: HTTPClientAPIEndPoint {

    enum Path {

        case contributors

        var pathString: String {
            switch self {
            case .contributors:
                return "repos/videolan/vlc/contributors"
            }
        }

    }

    let path: Path

    // MARK: - HTTPClientAPIEndPoint

    func urlString() -> String {
        return "https://api.github.com/" + path.pathString
    }

}
