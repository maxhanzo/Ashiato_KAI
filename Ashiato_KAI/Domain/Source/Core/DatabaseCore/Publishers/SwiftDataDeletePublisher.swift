//
//  SwiftDataDeletePublisher.swift
//
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Combine
import Foundation
import SwiftData

struct SwiftDataDeletePublisher<Entity>: Publisher where Entity: PersistentModel {
    typealias Output = Void
    typealias Failure = Error
    
    private let type: DeletionType
    private let context: ModelContext
    
    init(type: DeletionType, context: ModelContext) {
        self.type = type
        self.context = context
    }
    
    func receive<S>(subscriber: S) where S: Subscriber, any Failure == S.Failure, Void == S.Input {
        let subscription = Subscription(
            subscriber: subscriber,
            type: type,
            context: context
        )
        subscriber.receive(subscription: subscription)
    }
}

extension SwiftDataDeletePublisher {
    enum DeletionType {
        case all(typeOf: Entity.Type, predicate: Predicate<Entity>? = nil, includeSubclasses: Bool = true)
        case entity(object: Entity)
    }
}

extension SwiftDataDeletePublisher {
    class Subscription<S> where S: Subscriber, S.Failure == Failure, S.Input == Output {
        private var subscriber: S?
        private let type: DeletionType
        private let context: ModelContext
        
        init(
            subscriber: S,
            type: DeletionType,
            context: ModelContext
        ) {
            self.subscriber = subscriber
            self.type = type
            self.context = context
        }
    }
}

extension SwiftDataDeletePublisher.Subscription: Subscription {
    func request(_ demand: Subscribers.Demand) {
        var demand = demand

        guard let subscriber, demand > 0 else { return }

        do {
            demand -= 1

            AKLogger.debug(prefix: .dataBase, message: "Deleting data type \(String(describing: Entity.self))")

            // Perform deletion
            switch type {
            case .all(let type, let predicate, let includeSubclasses):
                try context.delete(model: type, where: predicate, includeSubclasses: includeSubclasses)
            case .entity(let entity):
                context.delete(entity)
            }

            if context.hasChanges {
                try context.save()
                AKLogger.debug(prefix: .dataBase, message: "Context saved after deletion")
            } else {
                AKLogger.debug(prefix: .dataBase, message: "No changes to save in context")
            }

            demand += subscriber.receive()
            subscriber.receive(completion: .finished)
        } catch let error {
            AKLogger.error(prefix: .dataBase, message: "Data deletion failed", params: error)
            subscriber.receive(completion: .failure(error))
        }
    }
    
    func cancel() {
        subscriber = nil
    }
}
