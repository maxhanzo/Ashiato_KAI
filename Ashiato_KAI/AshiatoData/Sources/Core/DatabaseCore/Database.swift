//
//  Database.swift
//
//
//  Created by UedaSoft IT Solutions on 23/02/25.
//

import Foundation
import SwiftData

public struct Database: SwiftDataStoring {
    private let store: SwiftDataStoring
    
    @MainActor
    public var context: ModelContext {
        store.context
    }
    
    public init(store: SwiftDataStoring) {
        self.store = store
    }
}
