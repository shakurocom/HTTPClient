//
//
//

import Foundation
import HTTPClient_Framework

internal class ExampleParser: HTTPClientParser {

    typealias ResponseValueType = Data
    typealias ResultType = Data

    internal func serializeResponseData(_ responseData: Data?) throws -> ResponseValueType {
        guard let realData = responseData else {
            throw HTTPClient.Error.cantSerializeResponseData(underlyingError: nil)
        }
        return realData
    }

    internal func parseForError(response: HTTPURLResponse?, responseData: Data?) -> Swift.Error? {
        return nil
    }

    internal func parseForResult(_ serializedResponse: ResponseValueType, response: HTTPURLResponse?) throws -> ResultType {
        return serializedResponse
    }

}
