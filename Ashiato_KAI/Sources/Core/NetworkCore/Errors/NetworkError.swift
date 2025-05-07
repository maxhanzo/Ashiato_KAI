//
//  NetworkError.swift
//  
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Foundation

public enum NetworkError: ErrorMappable {
    case invalidURL
    case noConnection
    case unknown(Error)
    
    init(_ error: URLError) {
        switch error.code {
        case URLError.badURL,
             URLError.unsupportedURL:
            self = .invalidURL
        case URLError.cannotConnectToHost,
             URLError.networkConnectionLost,
             URLError.notConnectedToInternet:
            self = .noConnection
        default:
            self = .unknown(error)
        }
    }
}

extension NetworkError {
    public var debugDescription: String {
        switch self {
        case .invalidURL:
            return """
            ❌ Invalid URL Error ❌\n
            """
        case .noConnection:
            return """
            ❌ No Connection Error ❌\n
            """
        case .unknown(let error):
            return """
            ❌ Unknown Error ❌
            Error: \(error)\n
            """
        }
    }
    
    public var description: String {
        switch self {
        case .invalidURL,
             .unknown:
            return "We encountered an internal issue. Please wait a moment and try again. If the problem continues, contact support."
        case .noConnection:
            return "It looks like you’re not connected to the internet. Please check your connection and try again."
        }
    }
}

extension NetworkError {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.noConnection, .noConnection):
            return true
        case (.unknown(let lhsError), .unknown(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
