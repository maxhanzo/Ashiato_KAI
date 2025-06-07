//
//  Coordinator.swift
//
//  Created by Uedasoft IT Solutions on 27/06/23.
//

import Combine
import SwiftUI

/// This an **protocol** that extends from `View` protocol.
///
/// The purpose of this protocol is to help in following the coordinator patterns and be a facilitator in dividing the route control responsibility inside of **MVVM-C** architecture over the SwiftUI that uses the **NavigationStack** component.
///
/// This is protocol should be implemented and it expects two generics types that conform with the **Routable** protocol.
/// Both generics are responsible for defining the possible routes for the coordinator's scope. Being one for **Screen** and the other for the **BottomSheet**.
public protocol Coordinator: View, ViewFactory {
    var presentationMode: Binding<PresentationMode> { get }
    var parent: (any Coordinator)? { get }
    var root: ViewRoute { get }
    var path: [AnyHashable] { get set }
    var sheetItem: RouteIdentifiable? { get set }
    var coverItem: RouteIdentifiable? { get set }
    var delayAnimationTime: TimeInterval { get }
}

public extension Coordinator where ViewRoute: ViewRoutable {
    var sheetItem: RouteIdentifiable? { nil }
    var coverItem: RouteIdentifiable? { nil }
    var delayAnimationTime: TimeInterval { 1.0 }
    
    @ViewBuilder
    func buildContent() -> some View {
        ZStack {
            view(for: root)
        }
        .tNavigationDestination(for: ViewRoute.self, destination: view(for:))
    }
}
