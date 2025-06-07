//
//  ProfileCoordinator.swift
//  MVVM-C_App
//
//  Created by Uedasoft IT Solutions on 01/04/25.
//

import DesignPatterns
import SwiftUI

protocol ProfileCoordinatorInterface: Coordinator {
    var onCompletion: PassthroughSubject<Void, Never> { get }

    func showMyAccount()
    func backToSubDetails()
    func backToDetails()
    func onCompletion()
}

struct ProfileCoordinator: ProfileCoordinatorInterface {
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    
    @Environment(\.parentCoordinator)
    var parent
    
    var root: ViewRoute = .profile
    
    @Binding
    public var path: [AnyHashable]
    
    @State
    public var sheetItem: RouteIdentifiable?
    
    @State
    public var coverItem: RouteIdentifiable?
    
    var onCompletion: PassthroughSubject<Void, Never> = .init()
        
    var body: some View {
        if parent == nil {
            TNavigationStack(
                path: $path,
                root: buildContent
            )
        } else {
            buildContent()
        }
    }
    
    func view(for route: ViewRoute) -> some View {
        switch route {
        case .profile:
            ProfileView(viewModel: .init(self))
        case .myAccount:
            MyAccountView(viewModel: .init(self))
        }
    }
}

extension ProfileCoordinator {
    enum ViewRoute: ViewRoutable {
        case profile
        case myAccount
    }
    
    enum BottomSheetRoute: BottomSheetRoutable {
        public var configuration: BottomSheetConfiguration { .default }
    }
}

extension ProfileCoordinator {
    func showMyAccount() {
        push(ProfileCoordinator.ViewRoute.myAccount)
    }
    
    func backToDetails() {
        popTo(HomeCoordinator.ViewRoute.subDetails)
    }
    
    func backToSubDetails() {
        popTo(HomeCoordinator.ViewRoute.subDetails)
    }
    
    func onCompletion() {
        Task {
            await dismiss()
            onCompletion.send()
        }
    }
}
