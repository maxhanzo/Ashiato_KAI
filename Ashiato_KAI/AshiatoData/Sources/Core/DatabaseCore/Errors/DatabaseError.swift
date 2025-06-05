//
//  DatabaseError.swift
//  GGData
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Foundation

public enum DatabaseError: ErrorMappable {
    case notFound
    case invalidData
    case invalidQuery
}

extension DatabaseError {
    public var debugDescription: String {
        switch self {
        case .notFound:
            return """
            ❌ Data not found ❌
            """
        case .invalidData:
            return """
            ❌ Invalid data ❌
            """
        case .invalidQuery:
            return """
            ❌ Invalid operation ❌
            """
        }
    }
    
    public var description: String {
        switch self {
        case .notFound,
             .invalidData,
             .invalidQuery:
            return "We encountered an internal issue. Please wait a moment and try again. If the problem continues, contact support."
        }
    }
}
