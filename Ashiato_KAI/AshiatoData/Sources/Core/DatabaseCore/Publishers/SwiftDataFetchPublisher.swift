//
//  SwiftDataFetchPublisher.swift
//
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Combine
import Foundation
import SwiftData

struct SwiftDataFetchPublisher<Entity>: Publisher where Entity: PersistentModel {
    typealias Output = [Entity]
    typealias Failure = Error
    
    private let descriptor: FetchDescriptor<Entity>
    private let batchSize: Int?
    private let context: ModelContext

    init(descriptor: FetchDescriptor<Entity>, batchSize: Int? = nil, context: ModelContext) {
        self.descriptor = descriptor
        self.batchSize = batchSize
        self.context = context
    }
    
    func receive<S>(subscriber: S) where S: Subscriber, any Failure == S.Failure, [Entity] == S.Input {
        let subscription = Subscription(
            subscriber: subscriber,
            descriptor: descriptor,
            batchSize: batchSize,
            context: context
        )
        subscriber.receive(subscription: subscription)
    }
}

extension SwiftDataFetchPublisher {
    class Subscription<S> where S: Subscriber, S.Failure == Failure, S.Input == Output {
        private var subscriber: S?
        private let descriptor: FetchDescriptor<Entity>
        private let batchSize: Int?
        private let context: ModelContext

        init(
            subscriber: S,
            descriptor: FetchDescriptor<Entity>,
            batchSize: Int? = nil,
            context: ModelContext
        ) {
            self.subscriber = subscriber
            self.descriptor = descriptor
            self.batchSize = batchSize
            self.context = context
        }
    }
}

extension SwiftDataFetchPublisher.Subscription: Subscription {
    func request(_ demand: Subscribers.Demand) {
        var demand = demand
        
        guard let subscriber, demand > 0 else { return }
        
        do {
            demand -= 1
            
            AKLogger.debug(prefix: .dataBase, message: "Fetching data \(String(describing: Entity.self))")

            let result: [Entity]
            
            if let batchSize {
                let fetchResult = try context.fetch(descriptor, batchSize: batchSize)
                result = Array(fetchResult)
            } else {
                result = try context.fetch(descriptor)
            }
            
            AKLogger.debug(prefix: .dataBase, message: "Fetching data result", params: result)

            demand += subscriber.receive(result)
            subscriber.receive(completion: .finished)
        } catch let error {
            AKLogger.error(prefix: .dataBase, message: "Fetching object failed", params: error)
            subscriber.receive(completion: .failure(error))
        }
    }
    
    func cancel() {
        subscriber = nil
    }
}
