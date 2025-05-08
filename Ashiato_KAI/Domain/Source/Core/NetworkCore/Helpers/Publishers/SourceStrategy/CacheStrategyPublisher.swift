//
//  PublisherSourceStrategy.swift
//
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Combine
import Foundation

public struct CacheStrategyPublisher: Publisher {
    public typealias Output = URLRequest
    public typealias Failure = Error
    
    private let monitor: NetworkMonitor
    private let request: URLRequest
    
    public init(request: URLRequest, monitor: NetworkMonitor = .shared) {
        self.monitor = monitor
        self.request = request
    }
    
    public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, URLRequest == S.Input {
        let subscription = Subscription(
            subscriber: subscriber,
            request: request,
            monitor: monitor
        )
        subscriber.receive(subscription: subscription)
    }
}

extension CacheStrategyPublisher {
    class Subscription<S> where S: Subscriber, S.Failure == Failure, S.Input == Output {
        private var subscriber: S?
        private let request: URLRequest
        private let monitor: NetworkMonitor
        
        init(subscriber: S, request: URLRequest, monitor: NetworkMonitor) {
            self.subscriber = subscriber
            self.request = request
            self.monitor = monitor
        }
    }
}

extension CacheStrategyPublisher.Subscription: Subscription {
    func request(_ demand: Subscribers.Demand) {
        var demand = demand
        
        guard let subscriber, demand > 0 else { return }
        
        demand -= 1
        
        let isConneted = monitor.isConnected

        var request = request
        request.cachePolicy = isConneted ? .useProtocolCachePolicy : .returnCacheDataElseLoad
        
        demand += subscriber.receive(request)
    }
    
    func cancel() {
        subscriber = nil
    }
}
