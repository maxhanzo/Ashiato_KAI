//
//  Routable.swift
//
//  Created by Uedasoft IT Solutions on 27/06/23.
//

import Foundation

public protocol Routable: Hashable, Identifiable { }

public extension Routable {
    var id: String { String(reflecting: self) }
    
    func asType<T>(of value: T.Type) -> T? {
        self as? T
    }
}
