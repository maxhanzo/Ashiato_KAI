//
//  Publisher+URLSessionDataTasks.swift
//  
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Combine
import Foundation

extension Publisher where Self.Output == URLRequest, Self.Failure == Error {
    func request(_ session: URLSession, provider: SessionProviderInterface) -> AnyPublisher<URLSession.DataTaskPublisher.Output, Error> {
        self.flatMap { request in
            SessionRequestPublisher(
                session: session,
                request: request,
                provider: provider
            )
        }
        .eraseToAnyPublisher()
    }
}

extension Publisher where Self.Output == URLSession.DataTaskPublisher.Output, Self.Failure == Error {
    func mapResponse(_ decoder: JSONDecoder = .iso8601Date) -> AnyPublisher<Data, Error> {
        self.tryMap {
            try ResponseMapper.map(result: $0, decoder: decoder)
        }
        .eraseToAnyPublisher()
    }
    
    func decode<T: Decodable>(_ type: T.Type, _ decoder: JSONDecoder = .iso8601Date) -> AnyPublisher<T, Error> {
        self.mapResponse()
            .decode(type: type, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
