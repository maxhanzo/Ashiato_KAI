//
//  Environment+Coordinator.swift
//
//
//  Created by Uedasoft IT Solutions on 22/01/25.
//

import SwiftUI

private struct CoordinatorEnvironmentKey: EnvironmentKey {
    static let defaultValue: (any Coordinator)? = nil
}

public extension EnvironmentValues {
    var parentCoordinator: (any Coordinator)? {
        get { self[CoordinatorEnvironmentKey.self] }
        set { self[CoordinatorEnvironmentKey.self] = newValue }
    }
}
