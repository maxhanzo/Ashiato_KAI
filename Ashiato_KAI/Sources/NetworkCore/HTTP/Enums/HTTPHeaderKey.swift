//
//  HTTPHeaderKey.swift
//
//
//  Created by UedaSoft IT Solutions on 18/04/25.
//

import Foundation

public enum HTTPHeaderKey: Hashable {
    case authorization
    case contentType
    case acceptType
    case acceptEncoding
    case userAgent
    case subscription
    case custom(String)
    
    public var rawValue: String {
        switch self {
        case .authorization:
            return "Authorization"
        case .contentType:
            return "Content-Type"
        case .acceptType:
            return "Accept"
        case .acceptEncoding:
            return "Accept-Encoding"
        case .userAgent:
            return "User-Agent"
        case .subscription:
            return "Ocp-Apim-Subscription-Key"
        case .custom(let field):
            return field
        }
    }
}
