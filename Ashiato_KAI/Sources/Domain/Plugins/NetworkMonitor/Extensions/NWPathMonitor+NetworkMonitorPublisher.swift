//
//  NWPathMonitor+PublisherReachability.swift
//
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Combine
import Foundation
import Network

public extension NWPathMonitor {
    func publisher(queue: DispatchQueue = .networkQueue) -> NetworkMonitorPublisher {
        NetworkMonitorPublisher(monitor: self, queue: queue)
    }
}
