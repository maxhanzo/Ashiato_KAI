//
//  SwiftDataEntityInserter.swift
//  
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Combine
import Foundation
import SwiftData

public protocol SwiftDataEntityInsert {
    var context: ModelContext { get }
    func insert<Entity>(_ entity: Entity..., autoSave: Bool) throws where Entity: PersistentModel
    func insert<Entity>(_ entity: Entity..., autoSave: Bool) async throws where Entity: PersistentModel
    func insert<Entity>(_ entity: Entity..., autoSave: Bool) -> AnyPublisher<Void, Error> where Entity: PersistentModel
    func insert<Entity>(_ entity: [Entity], autoSave: Bool) throws where Entity: PersistentModel
    func insert<Entity>(_ entity: [Entity], autoSave: Bool) async throws where Entity: PersistentModel
    func insert<Entity>(_ entity: [Entity], autoSave: Bool) -> AnyPublisher<Void, Error> where Entity: PersistentModel
}

public extension SwiftDataEntityInsert {
    func insert<Entity>(_ entity: Entity..., autoSave: Bool) throws where Entity: PersistentModel {
        do {
            AKLogger.debug(prefix: .dataBase, message: "Inserting data \(String(describing: Entity.self))")
            AKLogger.debug(prefix: .dataBase, message: "Auto save enabled?... \(autoSave.description)")

            try context.transaction {
                for entity in entity {
                    context.insert(entity)
                }
                
                let hasChanges = context.hasChanges
                AKLogger.debug(prefix: .dataBase, message: "Has changes to save?... \(hasChanges.description)")
                
                if hasChanges, autoSave {
                    try context.save()
                }
            }
            
            AKLogger.debug(prefix: .dataBase, message: "Data saved with success")
        } catch let error {
            AKLogger.error(prefix: .dataBase, message: "Data insertion failed", params: error)
            throw error
        }
    }
    
    func insert<Entity>(_ entity: Entity..., autoSave: Bool) async throws where Entity: PersistentModel {
        try await insert(entity.compactMap(\.self), autoSave: autoSave)
    }
    
    func insert<Entity>(_ entity: Entity..., autoSave: Bool) -> AnyPublisher<Void, Error> where Entity: PersistentModel {
        insert(entity.compactMap(\.self), autoSave: autoSave)
    }
    
    func insert<Entity>(_ entity: [Entity], autoSave: Bool) throws where Entity: PersistentModel {
        do {
            AKLogger.debug(prefix: .dataBase, message: "Inserting data \(String(describing: Entity.self))")
            AKLogger.debug(prefix: .dataBase, message: "Auto save enabled?... \(autoSave.description)")

            try context.transaction {
                for entity in entity {
                    context.insert(entity)
                }
                
                let hasChanges = context.hasChanges
                AKLogger.debug(prefix: .dataBase, message: "Has changes to save?... \(hasChanges.description)")
                
                if hasChanges, autoSave {
                    try context.save()
                }
            }
            
            AKLogger.debug(prefix: .dataBase, message: "Data saved with success")
        } catch let error {
            AKLogger.error(prefix: .dataBase, message: "Data insertion failed", params: error)
            throw error
        }
    }
    
    func insert<Entity>(_ entity: [Entity], autoSave: Bool) async throws where Entity: PersistentModel {
        try await SwiftDataInsertPublisher(entity: entity, autoSave: autoSave, context: context)
            .eraseToAnyPublisher()
            .async()
    }
    
    func insert<Entity>(_ entity: [Entity], autoSave: Bool) -> AnyPublisher<Void, Error> where Entity: PersistentModel {
        SwiftDataInsertPublisher(entity: entity, autoSave: autoSave, context: context)
            .eraseToAnyPublisher()
    }
}
