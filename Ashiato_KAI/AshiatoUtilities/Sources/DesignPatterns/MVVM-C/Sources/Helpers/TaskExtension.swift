//
//  TaskExtension.swift
//
//  Created by Uedasoft IT Solutions on 10/07/23.
//

import Foundation

internal
extension Task where Success == Never, Failure == Never {
    static func sleep(for seconds: TimeInterval) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await self.sleep(nanoseconds: duration)
    }
}
