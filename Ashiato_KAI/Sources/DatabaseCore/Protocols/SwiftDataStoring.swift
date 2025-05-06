//
//  SwiftDataStoring.swift
//  
//
//  Created by UedaSoft IT Solutions on 03/05/25.
//

import Foundation
import SwiftData

public protocol SwiftDataStoring: SwiftDataEntityInsert, SwiftDataEntityFetch, SwiftDataEntitySave, SwiftDataEntityDelete {
    var context: ModelContext { get }
    func rollback()
    func wipeData(_ models: [any PersistentModel.Type])
}

public extension SwiftDataStoring {
    func rollback() {
        AKLogger.debug(prefix: .dataBase, message: "Rolling back...")
        context.rollback()
        AKLogger.debug(prefix: .dataBase, message: "Rollback with success.")
    }
    
    func wipeData(_ models: [any PersistentModel.Type]) {
        AKLogger.debug(prefix: .dataBase, message: "Wiping all data...")
        do {
            try delete(models, includeSubclasses: true)
            AKLogger.debug(prefix: .dataBase, message: "Data wiped out successfully.")
        } catch let error {
            AKLogger.error(prefix: .dataBase, message: "Data wipe out failed. Rolling back...", params: error)
            rollback()
        }
    }
}
