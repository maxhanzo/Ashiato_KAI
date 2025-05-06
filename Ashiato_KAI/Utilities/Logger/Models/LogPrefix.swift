//
//  LogPrefix.swift
//  Ashiato: KAI
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Foundation

public struct LogPrefix: ExpressibleByStringLiteral, ExpressibleByStringInterpolation, CustomStringConvertible {
    public var description: String

    public init(stringLiteral value: String) {
        description = value
    }
    
    public init(stringInterpolation: StringInterpolation) {
        description = stringInterpolation.output
    }
}

extension LogPrefix {
    public struct StringInterpolation: StringInterpolationProtocol {
        var output = ""
        
        public init(literalCapacity: Int, interpolationCount: Int) {
            output.reserveCapacity(literalCapacity * 2)
        }
        
        public mutating func appendLiteral(_ literal: String) {
            output.append(literal)
        }
        
        public mutating func appendInterpolation(prefix: LogPrefix) {
            output.append(prefix.description)
        }
        
        public mutating func appendInterpolation(_ string: String) {
            output.append(string)
        }
    }
}
