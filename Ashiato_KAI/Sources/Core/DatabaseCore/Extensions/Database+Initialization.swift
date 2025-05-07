//
//  Database+Initialization.swift
//  Ashiato_KAI
//
//  Created by Max Ueda on 07/05/25.
//

import Foundation

extension SwiftDataStore {
    static let persistent: SwiftDataStore = {
        SwiftDataStore(schema: .init(versionedSchema: SchemaV1.self))
    }()
    
    static let inMemory: SwiftDataStore = {
        SwiftDataStore(schema: .init(versionedSchema: SchemaV1.self), type: .inMemory)
    }()
}

extension Database {
    public static let main: Database = {
        Database(store: SwiftDataStore.persistent)
    }()
    
    public static let mocked: Database = {
        Database(store: SwiftDataStore.inMemory)
    }()
}
