//
//  HTTPTask.swift
//  
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Foundation

public enum HTTPTask {
    case requestPlain
    case requestParameters(parameters: [String: Any])
    case requestJSONEncodable(encodable: Encodable, encoder: JSONEncoder = JSONEncoder())
    case requestURLEncodable(parameters: [String: Any])
}
