//
//  ViewFactory.swift
//
//
//  Created by Uedasoft IT Solutions on 19/06/25.
//
// swiftlint:disable type_name

import SwiftUI

public protocol ViewFactory {
    associatedtype ViewRoute
    associatedtype BottomSheetRoute
    
    associatedtype V: View
    associatedtype B: View
    
    @ViewBuilder
    func view(for route: ViewRoute) -> V
    
    @ViewBuilder
    func bottomSheet(for route: BottomSheetRoute) -> B
}

public extension ViewFactory {
    @ViewBuilder
    func view(for route: ViewRoute) -> some View { }
    
    @ViewBuilder
    func bottomSheet(for route: BottomSheetRoute) -> some View { }
}

// swiftlint:enable type_name
