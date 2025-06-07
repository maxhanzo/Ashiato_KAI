//
//  ViewModel.swift
//
//  Created by Uedasoft IT Solutions on 27/06/23.
//

import Combine
import SwiftUI

/// The **ViewModel** is an **open class** with default implementations and commons resources.
///
/// The purpose of this Class is to help in following the view model patterns and be a facilitator in dividing the data layer responsibility inside of **MVVM-C** architecture over the **SwiftUI**.
///
/// This base class should inherit and expect a generics type that conforms with the **Coordinator**  protocol. This generic is responsible for implementing navigation control over the routes.
/// 
open class ViewModel<C>: Identifiable, ObservableObject, Hashable
where C: Coordinator {
    public var coordinator: C?
    public var cancellableBag: Set<AnyCancellable>

    deinit {
        disposable()
    }
    
    public init(_ coordinator: C? = nil) {
        self.cancellableBag = .init()
        self.coordinator = coordinator
    }
    
    open func disposable() {
        cancellableBag.forEach { $0.cancel() }
        coordinator = nil
    }

    @discardableResult
    public func setCoordinator(_ coordinator: C?) -> Self {
        self.coordinator = coordinator
        return self
    }
}

public extension ViewModel {
    nonisolated
    static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    nonisolated
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
