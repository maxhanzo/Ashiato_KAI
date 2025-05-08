//
//  Data+Converters.swift
//  Ashiato: KAI
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Foundation

public extension Data {
    var asString: String? {
        String(data: self, encoding: .utf8)
    }
}
