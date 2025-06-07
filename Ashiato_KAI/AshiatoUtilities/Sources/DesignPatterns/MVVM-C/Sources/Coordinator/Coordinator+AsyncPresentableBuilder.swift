//
//  Coordinator+AsyncPresentableBuilder.swift
//
//
//  Created by Uedasoft IT Solutions on 01/04/25.
//

import Foundation

/// This implement several async methods responsible for navigation control following the builder pattern.
///
/// The main idea of this  is to bring asynchronism to navigation control, together with a builder pattern that allows building an async sequence of navigation.
public extension Coordinator where ViewRoute: ViewRoutable {
    /// This method is responsible to, create a task that will take some while in accord with the **duration** value received as a parameter.
    /// - Parameter duration: Is a struct that allows defining the time unit in a simple way.
    /// - Returns: An instance of self-class with all changes made, following the builder pattern.
    @MainActor
    @available(iOS 14.0, *)
    @discardableResult
    func delay(for seconds: TimeInterval) async -> Self {
        try? await Task.sleep(for: seconds)
        return self
    }

    /// This method is responsible to, create a task that will take some while in accord with the **seconds** value received as a parameter.
    /// - Parameter seconds: Is a **TimeInterval** in **seconds** unit time.
    /// - Returns: An instance of self-class with all changes made, following the builder pattern.
    @MainActor
    @available(iOS 16.0, *)
    @discardableResult
    func delay(for duration: Duration) async -> Self {
        try? await Task.sleep(for: duration)
        return self
    }

    /// This method is responsible to, initiate a new **Scene** in full screen cover presentation  style  according to the **route** value received as a parameter, doing this inside of the new **Async Task** and storing inside of the **previousPresentationTask** property.
    /// - Parameter route: Is a generic defined by the class that are implementing that should conform with the **Routable** protocol
    /// - Parameter style: Is the type of the presentation. (e.g., `.sheet` or `.fullCover`)
    /// - Returns: An instance of self-class with all changes made, following the builder pattern.
    @MainActor
    @discardableResult
    mutating func present(_ route: any ViewRoutable, in style: PresentingStyle) async -> Self {
        await dismissSheetIfsNeeded(route)
        
        switch style {
        case .sheet:
            sheetItem = .init(wrappedValue: route)
        case .fullCover:
            coverItem = .init(wrappedValue: route)
        }
        
        await delay(for: delayAnimationTime)
        return self
    }
    
    /// This method is responsible to, initiate a new **View** in the BottomSheet presentation style according to the **route** value received as a parameter, doing this inside of the new **Async Task** and storing inside of the **previousPresentationTask** property.
    /// - Returns: An instance of self-class with all changes made, following the builder pattern.
    @MainActor
    @discardableResult
    mutating func present(_ route: any BottomSheetRoutable) async -> Self {
        await dismissSheetIfsNeeded(route)
        
        sheetItem = .init(wrappedValue: route)
        await delay(for: delayAnimationTime)
        
        return self
    }
    
    @MainActor
    @discardableResult
    mutating func dismiss(extraDelay: TimeInterval = 0.0) async -> Self {
        await popToRoot(withDelay: extraDelay)
        await MainActor.run {
            presentationMode.wrappedValue.dismiss()
        }
        return self
    }
    
    /// This method is responsible to ending full screen cover style presentation, doing this inside of the new **Async Task** and storing inside of the **previousPresentationTask** property.
    /// - Returns: An instance of self-class with all changes made, following the builder pattern.
    @MainActor
    @discardableResult
    mutating func dismissSheet(extraDelay: TimeInterval = 0.0) async -> Self {
        sheetItem = nil
        coverItem = nil
        await delay(for: delayAnimationTime)
        await delay(for: extraDelay)
        return self
    }
    
    @MainActor
    @discardableResult
    mutating func dismissSheetIfsNeeded(_ newRoute: (any Routable)? = nil) async -> Self {
        guard let newRoute else {
            if (sheetItem ?? coverItem) != nil {
                await dismissSheet()
            }
            return self
        }
        
        let targetRoute = RouteIdentifiable(wrappedValue: newRoute)
        guard let currentRoute = sheetItem ?? coverItem, currentRoute.id != targetRoute.id else {
            return self
        }
        
        await dismissSheet()
        return self
    }
    
    /// This method is responsible to, initiate a new **Scene** in pushing presentation style according to the **route** value received as a parameter, doing this inside of the new **Async Task** and storing inside of the **previousPresentationTask** property.
    /// - Parameter route: Is a generic defined by the class that are implementing that should conform with the **Routable** protocol
    /// - Returns: An instance of self-class with all changes made, following the builder pattern.
    @MainActor
    @discardableResult
    mutating func push(_ route: any ViewRoutable) async -> Self {
        path.append(AnyHashable(route))
        return self
    }

    /// This method is responsible to, execute back navigation to the previous **Scene**, doing this inside of the new **Async Task** and storing inside of the **previousPresentationTask** property.
    /// - Returns: An instance of self-class with all changes made, following the builder pattern.
    /// - Parameter dropCount: Is the number of views to drop
    @MainActor
    @discardableResult
    mutating func pop(_ dropCount: Int = 1, withDelay: TimeInterval = 0.0) async -> Self {
        await delay(for: withDelay)
        await dismissSheetIfsNeeded()
        path.pop(dropCount)
        return self
    }

    /// This method is responsible to, go back for a specific **Scene** in the navigation tree according to the **route** value received as a parameter, doing this inside of the new **Async Task** and storing inside of the **previousPresentationTask** property.
    /// - Parameter route: Is a generic defined by the class that are implementing that should conform with the **Routable** protocol
    /// - Returns: An instance of self-class with all changes made, following the builder pattern.
    @MainActor
    @discardableResult
    mutating func popTo(_ route: any ViewRoutable) async -> Self {
        await dismissSheetIfsNeeded()
        path.popTo(AnyHashable(route))
        return self
    }
    
    /// This method is responsible to, go back to root **Scene** in the navigation tree, doing this inside of the new **Async Task** and storing inside of the **previousPresentationTask** property.
    /// - Returns: An instance of self-class with all changes made, following the builder pattern.
    @MainActor
    @discardableResult
    mutating func popToRoot(withDelay: TimeInterval = 0.0) async -> Self {
        await delay(for: withDelay)
        await dismissSheetIfsNeeded()
        
        if parent != nil {
            await popAll(routes: ViewRoute.self)
        } else {
            path.popToRoot()
        }
        
        return self
    }
    
    /// This method is responsible to, drop all **Scene** in the navigation tree according to the **route** type received as a parameter, doing this inside of the new **Async Task** and storing inside of the **previousPresentationTask** property.
    /// - Parameter route: Is a generic defined by the class that are implementing that should conform with the **Routable** protocol
    /// - Returns: An instance of self-class with all changes made, following the builder pattern.
    @MainActor
    @discardableResult
    mutating func popAll<R: ViewRoutable>(routes typeOf: R.Type) async -> Self {
        await dismissSheetIfsNeeded()
        let count = path.filter { $0 is R }.count
        await pop(count)
        await delay(for: 0.6)
        return self
    }
}
