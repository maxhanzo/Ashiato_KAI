//
//  FetchSettings.swift
//
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Foundation
import SwiftData

public struct FetchSettings<Entity> where Entity: PersistentModel {
    public var predicate: Predicate<Entity>?
    public var sortBy: [SortDescriptor<Entity>]
    public var batchSize: Int?
    public var limit: Int?
    public var offset: Int?
    
    public init(
        predicate: Predicate<Entity>? = nil,
        sortBy: [SortDescriptor<Entity>] = [],
        batchSize: Int? = nil,
        limit: Int? = nil,
        offset: Int? = nil
    ) {
        self.predicate = predicate
        self.sortBy = sortBy
        self.batchSize = batchSize
        self.limit = limit
        self.offset = offset
    }
    
    public func buildDecriptor() -> FetchDescriptor<Entity> {
        var descriptor = FetchDescriptor<Entity>(
            predicate: predicate,
            sortBy: sortBy
        )
        descriptor.fetchLimit = limit
        descriptor.fetchOffset = offset
        return descriptor
    }
}
