//
//  DomainError.swift
//  
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Foundation

public struct DomainError: Decodable, ErrorMappable {
    let error: String
    public var description: String { error }
    public var debugDescription: String { error }
}
