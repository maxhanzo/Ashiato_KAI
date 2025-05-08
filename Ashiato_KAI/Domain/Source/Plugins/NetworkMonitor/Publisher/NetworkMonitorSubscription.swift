//
//  NetworkMonitorSubscription.swift
//
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Combine
import Foundation
import Network

final class NetworkMonitorSubscription<S: Subscriber>: Subscription where S.Input == NWPath {
    private let subscriber: S
    private let monitor: NWPathMonitor
    private let queue: DispatchQueue
    private var isStarted: Bool
    
    init(subscriber: S, monitor: NWPathMonitor, queue: DispatchQueue) {
        self.subscriber = subscriber
        self.monitor = monitor
        self.queue = queue
        self.isStarted = false
    }
    
    func request(_ demand: Subscribers.Demand) {
        precondition(demand == .unlimited, "This subscription is only supported to `Demand.unlimited`.")
        
        guard !isStarted else { return }
        isStarted = true
        
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            _ = self.subscriber.receive(path)
        }
        monitor.start(queue: queue)
    }
    
    func cancel() {
        monitor.cancel()
    }
}
