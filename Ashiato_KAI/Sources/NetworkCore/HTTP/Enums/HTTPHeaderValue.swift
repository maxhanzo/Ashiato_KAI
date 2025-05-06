//
//  HTTPHeaderValue.swift
//
//
//  Created by UedaSoft IT Solutions on 18/04/25.
//

import Foundation

public enum HTTPHeaderValue: Hashable {
    case json
    case formUrlEncoded
    case pdf
    case formData
    case jpeg
    case png
    case bearer(String)
    case custom(String)

    public var rawValue: String {
        switch self {
        case .json:
            return "application/json"
        case .formUrlEncoded:
            return "application/x-www-form-urlencoded"
        case .pdf:
            return "application/pdf"
        case .formData:
            return "form-data"
        case .jpeg:
            return "image/jpeg"
        case .png:
            return "image/png"
        case .bearer(let token):
            return "Bearer \(token)"
        case .custom(let value):
            return value
        }
    }
}
