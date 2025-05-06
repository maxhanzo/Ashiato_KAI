//
//  NetworkEnvironment.swift
//
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Foundation

public enum NetworkEnvironment: Equatable {
    case develop(scheme: String = "https", host: String = "", key: String = "")
    case homol(scheme: String = "https", host: String = "", key: String = "")
    case prod(scheme: String = "https", host: String = "", key: String = "")
    
    var scheme: String {
        switch self {
        case .develop(let scheme, _, _),
             .homol(let scheme, _, _),
             .prod(let scheme, _, _):
            return scheme
        }
    }
    
    var host: String {
        switch self {
        case .develop(_, let host, _),
             .homol(_, let host, _),
             .prod(_, let host, _):
            return host
        }
    }
    
    var key: String {
        switch self {
        case .develop(_, _, let key),
             .homol(_, _, let key),
             .prod(_, _, let key):
            return key
        }
    }
}
