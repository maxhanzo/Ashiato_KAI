//
//  SwiftDataStore.swift
//
//
//  Created by UedaSoft IT Solutions on 03/05/25.
//

import Foundation
import SwiftData

public struct SwiftDataStore {
    private let schema: Schema
    private let config: ModelConfiguration
    private let modelContainer: ModelContainer

    @MainActor
    public var context: ModelContext {
        modelContainer.mainContext
    }
    
    static var `default`: SwiftDataStoring = {
        SwiftDataStore()
    }()
    
    public init(
        entities: (any PersistentModel.Type)...,
        migrationPlan: (any SchemaMigrationPlan.Type)? = nil,
        type: StorageType = .persistent
    ) {
        do {
            AKLogger.debug(prefix: .dataBase, message: "Database initializing...")
            schema = .init(entities)
            config = .init(schema: schema, isStoredInMemoryOnly: type == .inMemory)
            modelContainer = try .init(for: schema, migrationPlan: migrationPlan, configurations: [config])
            AKLogger.debug(prefix: .dataBase, message: "Database initialized")
        } catch let error {
            AKLogger.error(prefix: .dataBase, message: "Database initialization failed", params: error)
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    public init(
        schema: Schema,
        migrationPlan: (any SchemaMigrationPlan.Type)? = nil,
        type: StorageType = .persistent
    ) {
        do {
            AKLogger.debug(prefix: .dataBase, message: "Database initializing...")
            self.schema = schema
            self.config = .init(schema: schema, isStoredInMemoryOnly: type == .inMemory)
            self.modelContainer = try .init(for: schema, migrationPlan: migrationPlan, configurations: [config])
            AKLogger.debug(prefix: .dataBase, message: "Database initialized")
        } catch let error {
            AKLogger.error(prefix: .dataBase, message: "Database initialization failed", params: error)
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}

extension SwiftDataStore: SwiftDataStoring { }
