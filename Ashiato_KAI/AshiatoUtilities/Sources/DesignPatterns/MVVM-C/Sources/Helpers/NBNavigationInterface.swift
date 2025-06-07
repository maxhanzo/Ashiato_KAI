//
//  NBNavigationInterface.swift
//
//  Created by Uedasoft IT Solutions on 10/07/23.
//

import NavigationBackport
import SwiftUI

public typealias TNavigationStack = NBNavigationStack
public typealias TNavigationLink = NBNavigationLink
public typealias TNavigationPath = NBNavigationPath
public typealias TNavigator = Navigator
public typealias TPathNavigator = PathNavigator
public typealias TUseNavigationStackPolicy = UseNavigationStackPolicy

public extension View {
    @ViewBuilder
    func tNavigationDestination<D, C>(for pathElementType: D.Type, @ViewBuilder destination builder: @escaping (D) -> C) -> some View where D: Hashable, C: View {
        nbNavigationDestination(for: pathElementType, destination: builder)
    }

    @ViewBuilder
    func tNavigationDestination<V>(isPresented: Binding<Bool>, @ViewBuilder destination: () -> V) -> some View where V: View {
        nbNavigationDestination(isPresented: isPresented, destination: destination)
    }

    @ViewBuilder
    func tUseNavigationStack(_ policy: TUseNavigationStackPolicy) -> some View {
        nbUseNavigationStack(policy)
    }
}
