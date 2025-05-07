//
//  JSONHelper.swift
//  Ashiato: KAI
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Foundation

class JSONHelper {
    /// Converts an object to a pretty JSON string.
    /// - Parameter object: The object to convert. Can be `Encodable`, JSON-compatible (`[String: Any]`, arrays), or their combinations.
    /// - Returns: A pretty JSON string, or `nil` if conversion fails.
    static func toPrettyJSONString(from object: Any) -> String {
        // Handle JSON-compatible objects
        if JSONSerialization.isValidJSONObject(object) {
            return serializeJSON(object: object) ?? ""
        }
        
        // Handle Encodable objects
        if let encodable = object as? Encodable {
            return encodeEncodable(encodable: encodable) ?? ""
        }
        
        return "\(object)"
    }
    
    /// Converts JSON-compatible objects (`[String: Any]`, arrays) to a pretty JSON string.
    private static func serializeJSON(object: Any) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }
    
    /// Converts `Encodable` objects to a pretty JSON string.
    private static func encodeEncodable(encodable: Encodable) -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(encodable)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }
}
