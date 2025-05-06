//
//  DispatchQueue+NetworkMonitor.swift
//  GGUtilities
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Combine
import Foundation
import Network

public extension DispatchQueue {
    static var networkQueue: DispatchQueue {
        DispatchQueue(label: "network.monitor.queue")
    }
}
