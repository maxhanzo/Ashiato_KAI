//
//  NetworkMonitorPublisher.swift
//
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Combine
import Foundation
import Network

public struct NetworkMonitorPublisher: Publisher {
    public typealias Output = NWPath
    public typealias Failure = Never
    
    private let monitor: NWPathMonitor
    private let queue: DispatchQueue
    
    public init(monitor: NWPathMonitor, queue: DispatchQueue) {
        self.monitor = monitor
        self.queue = queue
    }
    
    public func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, NWPath == S.Input {
        let subscription = NetworkMonitorSubscription(
            subscriber: subscriber,
            monitor: monitor,
            queue: queue
        )
        subscriber.receive(subscription: subscription)
    }
}
