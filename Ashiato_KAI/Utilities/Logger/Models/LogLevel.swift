//
//  LogLevel.swift
//  Ashiato: KAI
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Foundation

public enum LogLevel: String {
    case `default`
    case trace
    case debug
    case info
    case notice
    case warning
    case error
    case critical
    case fault
    
    var description: String {
        rawValue.uppercased()
    }
    
    var icon: String {
        switch self {
        case .default:
            return "🔘"
        case .trace:
            return "🟣"
        case .debug:
            return "⚪️"
        case .info:
            return "🔵"
        case .notice,
             .warning:
            return "🟡"
        case .error,
             .critical:
            return "🔴"
        case .fault:
            return "🟠"
        }
    }
}
