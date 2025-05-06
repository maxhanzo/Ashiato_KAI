//
//  NetworkMonitor.swift
//  GGUtilities
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Combine
import Foundation
import Network

@Observable
public final class NetworkMonitor {
    public static let shared = NetworkMonitor()
    public var onStatusChange: PassthroughSubject<Bool, Never>
    public var isConnected: Bool { didSet { onStatusChange.send(isConnected) } }
    public var onWifi: Bool
    public var onCellular: Bool
    private let monitor: NWPathMonitor
    
    private init() {
        isConnected = false
        onWifi = false
        onCellular = false
        onStatusChange = .init()
        monitor = .init()
        
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            self.updateHandler(path)
        }
        monitor.start(queue: .networkQueue)
    }
    
    private func updateHandler(_ path: NWPath) {
        isConnected = (path.status == .satisfied)
        onWifi = path.usesInterfaceType(.wifi)
        onCellular = path.usesInterfaceType(.cellular)
    }
}
