//
//  HTTPHeader.swift
//  
//
//  Created by UedaSoft IT Solutions on 18/04/25.
//

import Foundation

public final class HTTPHeader {
    public typealias TokenProviderAdapter = () -> String
    private var content: [HTTPHeaderKey: HTTPHeaderValue] = [:]
    private var tokenProvider: TokenProviderAdapter?
    
    public init(tokenProvider: TokenProviderAdapter? = nil) {
        self.tokenProvider = tokenProvider
    }
    
    public static var `default`: HTTPHeader {
        HTTPHeader()
            .addJSONContentType()
    }
    
    public static func authorized(tokenProvider: @escaping TokenProviderAdapter) -> HTTPHeader {
        HTTPHeader(tokenProvider: tokenProvider)
            .addJSONContentType()
            .addAuthorization()
    }
    
    public func rawValue() -> [String: String] {
        content
            .reduce([:]) {
                var dict = $0
                dict[$1.key.rawValue] = $1.value.rawValue
                return dict
            }
    }
    
    @discardableResult
    public func addCustom(key: String, value: String) -> Self {
        content[.custom(key)] = .custom(value)
        return self
    }
    
    @discardableResult
    public func addJSONContentType() -> Self {
        content[.contentType] = .json
        return self
    }
    
    @discardableResult
    public func addAuthorization() -> Self {
        guard let tokenProvider else { return self }
        return addAuthorization(tokenProvider())
    }
    
    @discardableResult
    public func addAuthorization(_ token: String) -> Self {
        content[.authorization] = .bearer(token)
        return self
    }
}
