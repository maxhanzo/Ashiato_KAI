//
//  SwiftDataInsertPublisher.swift
//
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Combine
import Foundation
import SwiftData

struct SwiftDataInsertPublisher<Entity>: Publisher where Entity: Collection, Entity.Element: PersistentModel {
    typealias Output = Void
    typealias Failure = Error
    
    private let entity: Entity
    private let autoSave: Bool
    private let context: ModelContext
    
    init(entity: Entity, autoSave: Bool, context: ModelContext) {
        self.entity = entity
        self.autoSave = autoSave
        self.context = context
    }
    
    func receive<S>(subscriber: S) where S: Subscriber, any Failure == S.Failure, Void == S.Input {
        let subscription = Subscription(
            subscriber: subscriber,
            entity: entity,
            autoSave: autoSave,
            context: context
        )
        subscriber.receive(subscription: subscription)
    }
}

extension SwiftDataInsertPublisher {
    class Subscription<S> where S: Subscriber, S.Failure == Failure, S.Input == Output {
        private var subscriber: S?
        private let entity: Entity
        private let autoSave: Bool
        private let context: ModelContext
        
        init(
            subscriber: S,
            entity: Entity,
            autoSave: Bool,
            context: ModelContext
        ) {
            self.subscriber = subscriber
            self.entity = entity
            self.autoSave = autoSave
            self.context = context
        }
    }
}

extension SwiftDataInsertPublisher.Subscription: Subscription {
    func request(_ demand: Subscribers.Demand) {
        var demand = demand
        
        guard let subscriber, demand > 0 else { return }
        
        do {
            demand -= 1
            
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
                        
            demand += subscriber.receive()
            subscriber.receive(completion: .finished)
        } catch let error {
            AKLogger.error(prefix: .dataBase, message: "Data insertion failed", params: error)
            subscriber.receive(completion: .failure(error))
        }
    }
    
    func cancel() {
        subscriber = nil
    }
}
