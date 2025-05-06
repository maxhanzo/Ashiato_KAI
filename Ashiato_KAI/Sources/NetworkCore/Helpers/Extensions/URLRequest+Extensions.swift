//
//  URLRequest+Extensions.swift
//  GGData
//
//  Created by UedaSoft IT Solutions on 27/05/25.
//

import Foundation

extension URLRequest {
    var isAuthenticated: Bool {
        let field = allHTTPHeaderFields?[HTTPHeaderKey.authorization.rawValue] ?? ""
        return !field.isEmpty
    }
}

extension URLRequest: Codable {
    enum CodingKeys: String, CodingKey {
        case url
        case httpMethod
        case allHTTPHeaderFields
        case httpBody
        case timeoutInterval
        case cachePolicy
        case allowsCellularAccess
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // Encode the URL
        try container.encode(url, forKey: .url)
        
        // Encode the HTTP method
        try container.encode(httpMethod, forKey: .httpMethod)
        
        // Encode all HTTP header fields
        try container.encode(allHTTPHeaderFields, forKey: .allHTTPHeaderFields)
        
        // Encode the HTTP body as Base64
        if let body = httpBody {
            try container.encode(body.base64EncodedString(), forKey: .httpBody)
        }
        
        // Encode the timeout interval
        try container.encode(timeoutInterval, forKey: .timeoutInterval)
        
        // Encode the cache policy (as rawValue for enum)
        try container.encode(cachePolicy.rawValue, forKey: .cachePolicy)
        
        // Encode allowsCellularAccess
        try container.encode(allowsCellularAccess, forKey: .allowsCellularAccess)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode the URL
        let url = try container.decode(URL.self, forKey: .url)
        
        // Initialize the URLRequest with the decoded URL
        self.init(url: url)
        
        // Decode the HTTP method
        self.httpMethod = try container.decodeIfPresent(String.self, forKey: .httpMethod)
        
        // Decode all HTTP header fields
        self.allHTTPHeaderFields = try container.decodeIfPresent([String: String].self, forKey: .allHTTPHeaderFields)
        
        // Decode the HTTP body from Base64
        if let bodyBase64 = try container.decodeIfPresent(String.self, forKey: .httpBody),
           let bodyData = Data(base64Encoded: bodyBase64) {
            self.httpBody = bodyData
        }
        
        // Decode the timeout interval
        self.timeoutInterval = try container.decode(TimeInterval.self, forKey: .timeoutInterval)
        
        // Decode the cache policy from rawValue
        let cachePolicyRawValue = try container.decode(UInt.self, forKey: .cachePolicy)
        self.cachePolicy = URLRequest.CachePolicy(rawValue: cachePolicyRawValue) ?? .useProtocolCachePolicy
        
        // Decode allowsCellularAccess
        self.allowsCellularAccess = try container.decode(Bool.self, forKey: .allowsCellularAccess)
    }
}
