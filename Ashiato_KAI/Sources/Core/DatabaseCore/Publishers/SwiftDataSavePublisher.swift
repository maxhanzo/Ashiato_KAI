//
//  SwiftDataSavePublisher.swift
//
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Combine
import Foundation
import SwiftData

struct SwiftDataSavePublisher: Publisher {
    typealias Output = Void
    typealias Failure = Error
    
    private let block: () -> Void
    private let context: ModelContext
    
    init(_ block: @escaping () -> Void, context: ModelContext) {
        self.block = block
        self.context = context
    }
    
    func receive<S>(subscriber: S) where S: Subscriber, any Failure == S.Failure, Void == S.Input {
        let subscription = Subscription(
            subscriber: subscriber,
            block: block,
            context: context
        )
        subscriber.receive(subscription: subscription)
    }
}

extension SwiftDataSavePublisher {
    class Subscription<S> where S: Subscriber, S.Failure == Failure, S.Input == Output {
        private var subscriber: S?
        private let block: () -> Void
        private let context: ModelContext
        
        init(
            subscriber: S,
            block: @escaping () -> Void,
            context: ModelContext
        ) {
            self.subscriber = subscriber
            self.block = block
            self.context = context
        }
    }
}

extension SwiftDataSavePublisher.Subscription: Subscription {
    func request(_ demand: Subscribers.Demand) {
        var demand = demand
        
        guard let subscriber, demand > 0 else { return }
        
        demand -= 1

        do {
            block()
            
            let hasChanges = context.hasChanges
            
            AKLogger.debug(prefix: .dataBase, message: "Has changes to save?... \(hasChanges.description)")
            
            if hasChanges {
                AKLogger.debug(prefix: .dataBase, message: "Saving data...")
                try context.save()
                AKLogger.debug(prefix: .dataBase, message: "Data saved with success!")
            }
            
            demand += subscriber.receive()
            subscriber.receive(completion: .finished)
        } catch let error {
            AKLogger.error(prefix: .dataBase, message: "Saving data failed", params: error)
            subscriber.receive(completion: .failure(error))
        }
    }
    
    func cancel() {
        subscriber = nil
    }
}
