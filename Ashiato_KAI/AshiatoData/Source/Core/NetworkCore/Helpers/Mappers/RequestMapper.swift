//
//  RequestMapper.swift
//
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Foundation

struct RequestMapper {
    static func map(_ request: URLRequest?) throws -> URLRequest {
        guard let request else {
            throw NetworkError.invalidURL
        }
        return request
    }
}
