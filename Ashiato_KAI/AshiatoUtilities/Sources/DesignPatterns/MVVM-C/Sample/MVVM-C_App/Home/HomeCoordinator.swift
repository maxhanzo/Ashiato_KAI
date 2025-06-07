//
//  HomeCoordinator.swift
//  MVVM-C_App
//
//  Created by Uedasoft IT Solutions on 01/04/25.
//

import DesignPatterns
import SwiftUI

protocol HomeCoordinatorInterface: Coordinator {
    func showDetail()
    func showSubDetail()
    func presentProfile()
    func showProfile()
    func popToRoot()
}

struct HomeCoordinator: HomeCoordinatorInterface {
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    
    @Environment(\.parentCoordinator)
    var parent
    
    var root: ViewRoute = .home

    @Binding
    public var path: [AnyHashable]
    
    @State
    public var sheetItem: RouteIdentifiable?
    
    @State
    public var coverItem: RouteIdentifiable?
    
    let profileCoordinator: any ProfileCoordinatorInterface
    
    init(
        root: ViewRoute = .home,
        path: Binding<[AnyHashable]>,
        profileCoordinator: any ProfileCoordinatorInterface
    ) {
        self.root = root
        self._path = path
        self.profileCoordinator = profileCoordinator
    }
    
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
        case .home:
            HomeView(viewModel: .init(self))
        case .details:
            HomeDetailsView(viewModel: .init(self))
        case .subDetails:
            HomeSubDetailsView(viewModel: .init(self))
                .sheet(item: $sheetItem, onDismiss: dismiss, content: view(for:))
                .fullScreenCover(item: $coverItem, onDismiss: dismiss, content: view(for:))
        case .profile:
            AnyView(profileCoordinator)
                .environment(\.parentCoordinator, self)
        }
    }
}

extension HomeCoordinator {
    enum ViewRoute: ViewRoutable {
        case home
        case details
        case subDetails
        case profile
    }
    
    enum BottomSheetRoute: BottomSheetRoutable {
        public var configuration: BottomSheetConfiguration { .default }
    }
}

extension HomeCoordinator {
    func showDetail() {
        push(HomeCoordinator.ViewRoute.details)
    }
    
    func showSubDetail() {
        push(HomeCoordinator.ViewRoute.subDetails)
    }
    
    func showProfile() {
        push(HomeCoordinator.ViewRoute.profile)
    }
    
    func presentProfile() {
        present(HomeCoordinator.ViewRoute.profile, in: .sheet)
    }
}
