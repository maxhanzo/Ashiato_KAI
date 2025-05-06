//
//  Loggable.swift
//  Ashiato: KAI
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Foundation
import OSLog

public protocol Loggable {
    static func log(_ message: String, params: Encodable?)
    static func trace(_ message: String, params: Encodable?)
    static func debug(_ message: String, params: Encodable?)
    static func info(_ message: String, params: Encodable?)
    static func notice(_ message: String, params: Encodable?)
    static func warning(_ message: String, params: Encodable?)
    static func error(_ message: String, params: Encodable?)
    static func critical(_ message: String, params: Encodable?)
    static func fault(_ message: String, params: Encodable?)
}
