//
//  URLSession+CacheStrategyPublisher.swift
//
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Combine
import Foundation

extension Publisher where Output == URLRequest, Failure == Error {
    func cacheStrategyPublisher() -> AnyPublisher<Output, Failure> {
        self.flatMap { request in
            CacheStrategyPublisher(request: request)
        }
        .eraseToAnyPublisher()
    }
}
