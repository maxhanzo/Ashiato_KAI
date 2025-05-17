//
//  Service.swift
//
//
//  Created by UedaSoft IT Solutions on 25/04/25.
//

import Foundation

open class Service {
    public let client: HTTPClient
    
    public init(_ env: NetworkEnvironment) {
        self.client = NetworkClient(env)
    }
    
    public init(_ client: HTTPClient) {
        self.client = client
    }
}
