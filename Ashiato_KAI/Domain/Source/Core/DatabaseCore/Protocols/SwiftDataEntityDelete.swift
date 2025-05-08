//
//  SwiftDataEntityDeleter.swift
//  
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Combine
import Foundation
import SwiftData

public protocol SwiftDataEntityDelete {
    var context: ModelContext { get }
    func delete<Entity>(_ object: Entity) throws where Entity: PersistentModel
    func delete<Entity>(_ object: Entity) -> AnyPublisher<Void, Error> where Entity: PersistentModel
    func delete<Entity>(_ type: Entity.Type, where predicate: Predicate<Entity>?, includeSubclasses: Bool) throws where Entity: PersistentModel
    func delete<Entity>(_ type: Entity.Type, where predicate: Predicate<Entity>?, includeSubclasses: Bool) -> AnyPublisher<Void, Error> where Entity: PersistentModel
    func delete(_ types: [any PersistentModel.Type], includeSubclasses: Bool) throws
}

public extension SwiftDataEntityDelete {
    func delete<Entity>(_ object: Entity) throws where Entity: PersistentModel {
        AKLogger.debug(prefix: .dataBase, message: "Deleting data type \(String(describing: Entity.self))")
        context.delete(object)
        AKLogger.debug(prefix: .dataBase, message: "Data deleted, saving context...")

        if context.hasChanges {
            try context.save()
            AKLogger.debug(prefix: .dataBase, message: "Context saved after deletion")
        } else {
            AKLogger.debug(prefix: .dataBase, message: "No changes to save in context")
        }
    }

    func delete<Entity>(_ object: Entity) -> AnyPublisher<Void, Error> where Entity: PersistentModel {
        SwiftDataDeletePublisher(type: .entity(object: object), context: context)
            .eraseToAnyPublisher()
    }

    func delete<Entity>(_ type: Entity.Type, where predicate: Predicate<Entity>?, includeSubclasses: Bool) throws where Entity: PersistentModel {
        do {
            AKLogger.debug(prefix: .dataBase, message: "Deleting data type \(String(describing: Entity.self))")
            try context.delete(model: type, where: predicate, includeSubclasses: includeSubclasses)
            AKLogger.debug(prefix: .dataBase, message: "Data deleted, saving context...")

            if context.hasChanges {
                try context.save()
                AKLogger.debug(prefix: .dataBase, message: "Context saved after deletion")
            } else {
                AKLogger.debug(prefix: .dataBase, message: "No changes to save in context")
            }
        } catch let error {
            AKLogger.error(prefix: .dataBase, message: "Data deletion failed", params: error)
            throw error
        }
    }

    func delete<Entity>(_ type: Entity.Type, where predicate: Predicate<Entity>?, includeSubclasses: Bool) -> AnyPublisher<Void, Error> where Entity: PersistentModel {
        SwiftDataDeletePublisher(type: .all(typeOf: type, predicate: predicate, includeSubclasses: includeSubclasses), context: context)
            .eraseToAnyPublisher()
    }

    func delete(_ types: [any PersistentModel.Type], includeSubclasses: Bool) throws {
        do {
            try context.transaction {
                try types.forEach { type in
                    AKLogger.debug(prefix: .dataBase, message: "Deleting data type \(String(describing: type))")
                    try context.delete(model: type, includeSubclasses: includeSubclasses)
                    AKLogger.debug(prefix: .dataBase, message: "Data deleted inside transaction")
                }
            }
            
            if context.hasChanges {
                try context.save()
                AKLogger.debug(prefix: .dataBase, message: "Context saved after transaction deletions")
            } else {
                AKLogger.debug(prefix: .dataBase, message: "No changes to save after transaction deletions")
            }    
        } catch let error {
            AKLogger.error(prefix: .dataBase, message: "Data deletion failed", params: error)
            throw error
        }
    }
}
