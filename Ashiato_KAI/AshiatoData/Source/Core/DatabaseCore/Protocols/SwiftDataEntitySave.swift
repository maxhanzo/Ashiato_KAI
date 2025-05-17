//
//  SwiftDataEntitySaver.swift
//
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Combine
import Foundation
import SwiftData

public protocol SwiftDataEntitySave {
    var context: ModelContext { get }
    func save(_ block: @escaping () -> Void) throws
    func save(_ block: @escaping () -> Void) async throws
    func save(_ block: @escaping () -> Void) -> AnyPublisher<Void, Error>
}

public extension SwiftDataEntitySave {
    func save(_ block: @escaping () -> Void) throws {
        block()
        let hasChanges = context.hasChanges

        AKLogger.debug(prefix: .dataBase, message: "Has changes to save?... \(hasChanges.description)")
        
        if hasChanges {
            AKLogger.debug(prefix: .dataBase, message: "Saving data...")
            try context.save()
            AKLogger.debug(prefix: .dataBase, message: "Data saved with success!")
        }
    }
    
    func save(_ block: @escaping () -> Void) async throws {
        try await SwiftDataSavePublisher(block, context: context)
            .eraseToAnyPublisher()
            .async()
    }
    
    func save(_ block: @escaping () -> Void) -> AnyPublisher<Void, Error> {
        SwiftDataSavePublisher(block, context: context)
            .eraseToAnyPublisher()
    }
}
