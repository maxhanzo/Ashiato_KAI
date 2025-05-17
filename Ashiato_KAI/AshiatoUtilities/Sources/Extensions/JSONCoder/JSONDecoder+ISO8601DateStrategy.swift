//
//  JSONDecoder+ISO8601DateStrategy.swift
//  Ashiato: KAI
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Foundation

public extension JSONDecoder {
    static let iso8601Date: JSONDecoder = {
        let decoder: JSONDecoder = .init()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}
