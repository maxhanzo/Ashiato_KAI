//
//  Coordinator+Presentable.swift
//
//
//  Created by Uedasoft IT Solutions on 01/04/25.
//

import Foundation

/// This implement several methods responsible for navigation control.
public extension Coordinator where ViewRoute: ViewRoutable {
    /// This method is responsible to, initiate a new **Scene** in full screen cover presentation style according to the **route** value received as a parameter.
    /// - Parameter route: Is a generic defined by the class that are implementing that should conform with the **Routable** protocol
    /// - Parameter style: Is the type of the presentation. (e.g., `.sheet` or `.fullCover`)
    @Sendable
    func present(_ route: any ViewRoutable, in style: PresentingStyle) {
        var `self` = self
        Task {
            await self.present(route, in: style)
        }
    }
    
    /// This method is responsible to, initiate a new **View** in the BottomSheet presentation style according to the **route** value received as a parameter.
    /// - Parameter route: Is a generic defined by the class that are implementing that should conform with the **BottomSheetRoutable** protocol
    @Sendable
    func present(_ route: any BottomSheetRoutable) {
        var `self` = self
        Task {
            await self.present(route)
        }
    }
    
    /// This method is responsible to ending coordinator presentation
    @Sendable
    func dismiss() {
        var `self` = self
        Task {
            await self.dismiss(extraDelay: 0.0)
        }
    }
    
    /// This method is responsible to ending full screen cover style presentation
    @Sendable
    func dismissSheet() {
        var `self` = self
        Task {
            await self.dismissSheet()
        }
    }

    /// This method is responsible to, initiate a new **Scene** in pushing presentation style according to the **route** value received as a parameter.
    /// - Parameter route: Is a generic defined by the class that are implementing that should conform with the **Routable** protocol
    @Sendable
    func push(_ route: any ViewRoutable) {
        var `self` = self
        Task {
            await self.push(route)
        }
    }
    
    /// This method is responsible to, execute back navigation to the previous **Scene**
    /// - Parameter dropCount: Is the number of views to drop
    @Sendable
    func pop(_ dropCount: Int = 1) {
        var `self` = self
        Task {
            await self.pop(dropCount)
        }
    }
    
    /// This method is responsible to, go back for a specific **Scene** in the navigation tree according to the**route** value received as a parameter.
    /// - Parameter route: Is a generic defined by the class that are implementing that should conform with the **Routable** protocol
    @Sendable
    func popTo(_ route: any ViewRoutable) {
        var `self` = self
        Task {
            await self.popTo(route)
        }
    }

    /// This method is responsible to, go back to root **Scene** in the navigation tree.
    @Sendable
    func popToRoot(withDelay: TimeInterval = 0.0) {
        var `self` = self
        Task {
            await self.popToRoot(withDelay: withDelay)
        }
    }
    
    /// This method is responsible to, drop all **Scene** in the navigation tree according to the **route** type received as a parameter.
    /// - Parameter route: Is a generic defined by the class that are implementing that should conform with the **Routable** protocol
    @Sendable
    func popAll<R: ViewRoutable>(routes typeOf: R.Type) {
        var `self` = self
        Task {
            await self.popAll(routes: typeOf)
        }
    }
}
