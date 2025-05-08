//
//  Dependency.swift
//  Ashiato: KAI
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Foundation

@propertyWrapper
public struct Dependency<T> {
    public lazy var wrappedValue: T = {
        DependencyContainer.resolve()
    }()
    
    public init() { }
}
