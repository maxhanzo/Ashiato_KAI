//
//  SwiftDataEntityFetcher.swift
//  
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Combine
import Foundation
import SwiftData

public protocol SwiftDataEntityFetch {
    var context: ModelContext { get }
    func fetch<Entity>(_ settings: FetchSettings<Entity>) throws -> [Entity] where Entity: PersistentModel
    func fetch<Entity>(_ settings: FetchSettings<Entity>) async throws -> [Entity] where Entity: PersistentModel
    func fetch<Entity>(_ settings: FetchSettings<Entity>) -> AnyPublisher<[Entity], Error> where Entity: PersistentModel
}

public extension SwiftDataEntityFetch {
    func fetch<Entity>(_ settings: FetchSettings<Entity>) throws -> [Entity] where Entity: PersistentModel {
        do {
            AKLogger.debug(prefix: .dataBase, message: "Fetching data \(String(describing: Entity.self))")

            let descriptor = settings.buildDecriptor()
            let result: [Entity]
            
            if let batchSize = settings.batchSize {
                let fetchResult = try context.fetch(descriptor, batchSize: batchSize)
                result = Array(fetchResult)
            } else {
                result = try context.fetch(descriptor)
            }
            
            AKLogger.debug(prefix: .dataBase, message: "Fetching data result", params: result)
            return result
        } catch let error {
            AKLogger.error(prefix: .dataBase, message: "Fetching object failed", params: error)
            throw error
        }
    }
    
    func fetch<Entity>(_ settings: FetchSettings<Entity>) async throws -> [Entity] where Entity: PersistentModel {
        try await SwiftDataFetchPublisher(
            descriptor: settings.buildDecriptor(),
            batchSize: settings.batchSize,
            context: context
        )
        .eraseToAnyPublisher()
        .async()
    }
    
    func fetch<Entity>(_ settings: FetchSettings<Entity>) -> AnyPublisher<[Entity], Error> where Entity: PersistentModel {
        SwiftDataFetchPublisher(
            descriptor: settings.buildDecriptor(),
            batchSize: settings.batchSize,
            context: context
        )
        .eraseToAnyPublisher()
    }
}
