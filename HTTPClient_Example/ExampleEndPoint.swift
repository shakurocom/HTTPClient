//
//
//

import Foundation
import HTTPClient_Framework

internal enum ExampleEndPoint: HTTPClientAPIEndPoint {

    case artworks

    internal func urlString() -> String {
        let server: String = "https://api.artic.edu/"
        let path: String
        switch self {
        case .artworks:
            path = "api/v1/artworks"
        }
        return server + path
    }

}
