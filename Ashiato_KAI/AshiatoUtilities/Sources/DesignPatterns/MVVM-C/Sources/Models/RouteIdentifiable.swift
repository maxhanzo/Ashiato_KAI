//
//  RouteIdentifiable.swift
//
//
//  Created by Uedasoft IT Solutions on 23/01/25.
//

import Foundation

public struct RouteIdentifiable: Identifiable {
    public var id: String { wrappedValue.id }
    public var wrappedValue: any Routable
    
    public static func == (lhs: RouteIdentifiable, rhs: RouteIdentifiable) -> Bool {
        rhs.id == lhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
