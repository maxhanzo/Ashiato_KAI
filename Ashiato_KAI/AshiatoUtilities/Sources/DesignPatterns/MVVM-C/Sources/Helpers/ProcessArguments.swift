//
//  ProcessArguments.swift
//  
//
//  Created by Uedasoft IT Solutions on 25/07/23.
//

import Foundation
import NavigationBackport

public enum ProcessArguments {
    public static var navigationStackPolicy: UseNavigationStackPolicy {
        // Allows the policy to be set from UI tests.
        ProcessInfo.processInfo.arguments.contains("USE_NAVIGATIONSTACK") ? .whenAvailable : .never
    }

    public static var nonEmptyAtLaunch: Bool {
        // Allows initial path to be set from UI tests.
        ProcessInfo.processInfo.arguments.contains("NON_EMPTY_AT_LAUNCH")
    }
}
