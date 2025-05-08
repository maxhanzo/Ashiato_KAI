//
//  ModelMappable.swift
//  Ashiato_KAI
//
//  Created by Max Ueda on 07/05/25.
//

import Foundation

public protocol ModelMappable {
    associatedtype Model
    init(from model: Model)
    func toModel() -> Model
}

public extension ModelMappable where Self: NSObject {
    init(from model: Model) {
        self.init()
    }
}
