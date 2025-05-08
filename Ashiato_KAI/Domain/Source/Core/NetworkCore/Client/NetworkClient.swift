//
//  NetworkClient.swift
//
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Combine
import Foundation

public class NetworkClient: HTTPClient {
    @Dependency
    private var sessionProvider: SessionProviderInterface
    
    private let env: NetworkEnvironment
    private let urlSession: URLSession
    private let decoder: JSONDecoder

    public init(
        _ env: NetworkEnvironment,
        urlSession: URLSession = .shared,
        timeout: TimeInterval = 15,
        decoder: JSONDecoder = .iso8601Date
    ) {
        self.env = env
        self.decoder = decoder
        self.urlSession = urlSession
        self.urlSession.configuration.timeoutIntervalForResource = timeout
    }
    
    public func perform<T>(_ target: TargetProvider, type: T.Type) -> AnyPublisher<T, Error> where T: Decodable {
        target.urlRequestPublisher(for: env, with: sessionProvider)
            .cacheStrategyPublisher()
            .log(prefix: .networking)
            .request(urlSession, provider: sessionProvider)
            .log(prefix: .networking)
            .decode(type, decoder)
            .mapError(ErrorMapper.map)
            .log(prefix: .networking)
            .eraseToAnyPublisher()
    }
    
    public func download(_ target: TargetProvider) -> AnyPublisher<Data, Error> {
        target.urlRequestPublisher(for: env, with: sessionProvider)
            .cacheStrategyPublisher()
            .log(prefix: .networking)
            .request(urlSession, provider: sessionProvider)
            .log(prefix: .networking)
            .mapResponse(decoder)
            .mapError(ErrorMapper.map)
            .log(prefix: .networking)
            .eraseToAnyPublisher()
    }
}
