//
//  AnyPublisher+ModelMappable.swift
//  Ashiato_KAI
//
//  Created by Max Ueda on 07/05/25.
//

import Combine
import Foundation

public extension AnyPublisher where Output: ModelMappable {
    func mapModel() -> Publishers.Map<Self, Output.Model> {
        map { $0.toModel() }
    }
}

public extension AnyPublisher where Output: Collection, Output.Element: ModelMappable {
    func mapModel() -> Publishers.Map<Self, [Output.Element.Model]> {
        map { $0.mapModel() }
    }
}

public extension AnyPublisher where Output: Collection, Output.Element: ModelMappable, Output.Element.Model: Hashable {
    func mapModel() -> Publishers.Map<Self, Set<Output.Element.Model>> {
        map { Set($0.mapModel()) }
    }
}
