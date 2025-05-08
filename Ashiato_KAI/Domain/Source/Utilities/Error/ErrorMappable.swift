//
//  ErrorMappable.swift
//  Ashiato: KAI
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Foundation

public protocol ErrorMappable: Error, CustomStringConvertible, Equatable {
    var debugDescription: String { get }
}

public extension ErrorMappable {
    var localizedDescription: String { description }
}
