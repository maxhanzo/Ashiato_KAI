//
//  Collection+ModelMappable.swift
//  Ashiato_KAI
//
//  Created by Max Ueda on 07/05/25.
//


import Foundation

public extension Collection where Element: ModelMappable {
    func mapModel() -> [Element.Model] {
        map { $0.toModel() }
    }
}

public extension Collection {
    func mapDTO<DTO>() -> [DTO] where DTO: ModelMappable, Element == DTO.Model {
        map(DTO.init)
    }
}
