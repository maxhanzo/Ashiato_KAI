//
//  DependencyContainer.swift
//  Ashiato: KAI
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Foundation

public final class DependencyContainer {
    private static let shared: DependencyContainer = .init()
    private var cache: [String: AnyObject] = [:]
    private var dependencies: [String: AnyDependency] = [:]
    
    public static func register<T>(_ dependency: @autoclosure @escaping () -> T) {
        shared.register(dependency)
    }
    
    public static func resolve<T>() -> T {
        shared.resolve()
    }
    
    private func register<T>(_ dependency: @autoclosure @escaping () -> T) {
        let key: String = .init(reflecting: T.self)
        guard dependencies[key] == nil else {
            return
        }
        dependencies[key] = AnyDependency {
            dependency() as AnyObject
        }
    }
    
    private func resolve<T>() -> T {
        let key: String = .init(reflecting: (() -> T).self)
        
        // Check cache first
        if let cachedInstance = cache[key] as? T {
            return cachedInstance
        }
        
        guard let dependency = dependencies[key] else {
            preconditionFailure("No dependency found for \(key)! Must register a dependency before resolve.")
        }
        
        guard let solver = dependency.resolve() as? (() -> T) else {
            preconditionFailure("Dependency registered for \(key) does not match the expected type \(T.self).")
        }
        
        let instance = solver()
        cache[key] = instance as AnyObject
        return instance
    }
}
