//
//
//

import Foundation
import HTTPClient_Framework

class ExampleParser: HTTPClientParser {

    internal struct Contributor {
        internal let identifier: Int
        internal let login: String
    }

    typealias ResponseValueType = [[String: Any]]
    typealias ResultType = [Contributor]

    func serializeResponseData(_ responseData: Data?) throws -> ResponseValueType {
        guard let data = responseData,
              let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
        else {
            throw HTTPClientError.cantSerializeResponseData(underlyingError: nil)
        }
        return json
    }

    func parseForError(response: HTTPURLResponse?, responseData: Data?) -> Swift.Error? {
        return nil
    }

    func parseForResult(_ serializedResponse: ResponseValueType, response: HTTPURLResponse?) throws -> ResultType {
        var contributors: [Contributor] = []
        for contributor in serializedResponse {
            guard let identifier = contributor["id"] as? Int,
                  let login = contributor["login"] as? String
            else {
                continue
            }
            contributors.append(Contributor(identifier: identifier, login: login))
        }
        return contributors
    }

}
