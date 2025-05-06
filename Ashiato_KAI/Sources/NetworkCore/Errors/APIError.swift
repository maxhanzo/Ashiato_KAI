//
//  APIError.swift
//
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Foundation

public enum APIError: ErrorMappable {
    case encode(EncodingError)
    case decode(DecodingError)
    case invalidResponse
    case internalServerError
    case noResponse
    case unauthorized
    case unexpectedStatusCode(Int, message: String?)
    case generic(Error)
    case custom(Decodable & CustomStringConvertible)
    case unknown
}

extension APIError {
    public var debugDescription: String {
        switch self {
        case .encode(let error):
            return """
            ❌ Encoding Error ❌
            Reason: \(error)\n
            """
        case .decode(let error):
            return """
            ❌ Decoding Error ❌
            Reason: \(error)\n
            """
        case .invalidResponse:
            return """
            ❌ Invalid response Error ❌
            """
        case .internalServerError:
            return """
            ❌ Internal Server Error ❌
            """
        case .noResponse:
            return """
            ❌ No response Error ❌
            """
        case .unauthorized:
            return """
            ❌ Unauthorized Error ❌
            """
        case .unexpectedStatusCode(let code, let message):
            return """
            ❌ Unexpected Status Code Error ❌
            Status code: \(code)\n
            Message: \(message ?? "")\n
            """
        case .generic(let error):
            return """
            ❌ Generic Error ❌
            Reason: \(error)\n
            """
        case .custom(let error):
            return """
            ❌ Domain Error ❌
            \(error)\n
            """
        case .unknown:
            return """
            ❌ Unknown Error ❌\n
            """
        }
    }
    
    public var description: String {
        switch self {
        case .encode,
             .decode,
             .invalidResponse,
             .internalServerError,
             .noResponse,
             .unexpectedStatusCode,
             .generic,
             .unknown:
            return "We encountered an internal issue. Please wait a moment and try again. If the problem continues, contact support."
        case .unauthorized:
            return "We couldn’t log you in. Please check your username and password and try again."
        case .custom(let error):
            return error.description
        }
    }
}

extension APIError: Equatable {
    public static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.encode(let lhsError), .encode(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription        
        case (.decode(let lhsError), .decode(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.generic(let lhsError), .generic(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.custom(let lhsError), .custom(let rhsError)):
            return lhsError.description == rhsError.description
        case (.unexpectedStatusCode(let lhsCode, let lhsMsg), .unexpectedStatusCode(let rhsCode, let rhsMsg)):
            return lhsCode == rhsCode && lhsMsg == rhsMsg
        case (.invalidResponse, .invalidResponse),
             (.noResponse, .noResponse),
             (.unauthorized, .unauthorized),
             (.unknown, .unknown):
            return true
        default:
            return false
        }
    }
}
