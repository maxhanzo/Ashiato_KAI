//
//  ResponseMapper.swift
//
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Foundation

struct ResponseMapper {
    static func map(
        result: URLSession.DataTaskPublisher.Output,
        decoder: JSONDecoder = .iso8601Date
    ) throws -> Data {
        guard let response = result.response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        switch response.statusCode {
        case 200...299:
            return result.data
        case 401:
            throw APIError.unauthorized
        case 500:
            throw APIError.internalServerError
        default:
            guard let error = try? decoder.decode(DomainError.self, from: result.data) else {
                throw APIError.unexpectedStatusCode(response.statusCode, message: result.data.asString)
            }
            throw APIError.custom(error)
        }
    }
}
