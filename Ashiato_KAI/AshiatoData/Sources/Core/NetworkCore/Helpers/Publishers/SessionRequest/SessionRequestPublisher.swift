//
//  SessionInterceptorPublisher.swift
//  GGData
//
//  Created by UedaSoft IT Solutions on 08/05/25.
//

import Combine
import Foundation

public struct SessionRequestPublisher: Publisher {
    public typealias Output = URLSession.DataTaskPublisher.Output
    public typealias Failure = Error
    
    private let session: URLSession
    private let request: URLRequest
    private let provider: SessionProviderInterface
    
    public init(
        session: URLSession,
        request: URLRequest,
        provider: SessionProviderInterface
    ) {
        self.session = session
        self.request = request
        self.provider = provider
    }
    
    public func receive<S>(subscriber: S) where S: Subscriber, S.Failure == Failure, S.Input == Output {
        let subscription = Subscription(
            subscriber: subscriber,
            session: session,
            request: request,
            provider: provider
        )
        subscriber.receive(subscription: subscription)
    }
}

extension SessionRequestPublisher {
    class Subscription<S> where S: Subscriber, S.Failure == Failure, S.Input == Output {
        private var subscriber: S?
        private let session: URLSession
        private let request: URLRequest
        private let provider: SessionProviderInterface

        init(
            subscriber: S,
            session: URLSession,
            request: URLRequest,
            provider: SessionProviderInterface
        ) {
            self.subscriber = subscriber
            self.session = session
            self.request = request
            self.provider = provider
        }
    }
}

extension SessionRequestPublisher.Subscription: Subscription {
    func request(_ demand: Subscribers.Demand) {
        var demand = demand
        
        guard let subscriber, demand > 0 else { return }
        
        demand -= 1
        
        session.dataTaskPublisher(for: request)
            .tryMap { output -> (data: Data, response: URLResponse) in
                if let httpResponse = output.response as? HTTPURLResponse, httpResponse.statusCode == 401 {
                    throw APIError.unauthorized
                }
                return output
            }
            .catch { [session, request, provider] error -> AnyPublisher<URLSession.DataTaskPublisher.Output, Error> in
                guard (error as? APIError) == APIError.unauthorized, request.isAuthenticated else {
                    return Fail(error: error)
                        .eraseToAnyPublisher()
                }
                
                return provider.tokenPublisher(true)
                    .map { [request] token -> URLRequest in
                        var updatedRequest = request
                        
                        if !token.isEmpty {
                            updatedRequest.setValue(
                                HTTPHeaderValue.bearer(token).rawValue,
                                forHTTPHeaderField: HTTPHeaderKey.authorization.rawValue
                            )
                        }
                        return updatedRequest
                    }
                    .flatMap { updatedRequest in
                        session.dataTaskPublisher(for: updatedRequest)
                            .mapError { $0 as Error }
                    }
                    .eraseToAnyPublisher()
            }
            .subscribe(subscriber)
    }
    
    func cancel() {
        subscriber = nil
    }
}
