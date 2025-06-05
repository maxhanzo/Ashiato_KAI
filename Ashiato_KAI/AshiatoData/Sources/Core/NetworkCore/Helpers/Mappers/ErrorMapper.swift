//
//  ErrorMapper.swift
//
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Foundation

struct ErrorMapper {
    static func map(_ error: Error) -> Error {
        switch error {
        case let error as URLError:
            return NetworkError(error)
        case let error as APIError:
            return error
        case let error as EncodingError:
            return APIError.encode(error)
        case let error as DecodingError:
            return APIError.decode(error)
        default:
            return APIError.generic(error)
        }
    }
}
