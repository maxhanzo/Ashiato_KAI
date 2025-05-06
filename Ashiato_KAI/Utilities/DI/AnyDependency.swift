//
//  AnyDependency.swift
//  Ashiato: KAI
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Foundation

class AnyDependency {
    private let _resolve: () -> AnyObject
    
    init<T: AnyObject>(_ resolve: @escaping () -> T) {
        _resolve = resolve
    }
    
    func resolve() -> AnyObject {
        _resolve()
    }
}
