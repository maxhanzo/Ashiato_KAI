//
//  Ashiato_KAIApp.swift
//  Ashiato_KAI
//
//  Created by Max Ueda on 05/06/25.
//

import DesignPatterns
import SwiftUI

@main
struct Ashiato_KAIApp: App {
    @Environment(\.scenePhase)
    var scenePhase
    
    @Environment(\.theme.view.main.primary)
    private var theme
    
    @State
    var manager: AppManager
    
    @State
    var path: [AnyHashable] = []
    
    @State
    private var splashScreenHidden: Bool = false
    private var splashScreenOpacity: Double {
        splashScreenHidden ? 0.0 : 1.0
    }
    
    init() {
        DependencyManager.setup()
        manager = .init()
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                theme.backgroundColor
                    .ignoresSafeArea()
                
                MainCoordinator(path: $path)
                    .environmentObject(manager)
                    .transition(.opacity.animation(.easeIn))
                    .animation(.easeIn(duration: 1.5), value: splashScreenHidden)
                    .isHidden(!splashScreenHidden, remove: true)
            }
            .overlay {
                SplashScreenView {
                    withAnimation {
                        splashScreenHidden = true
                    }
                }
                .transition(.opacity.animation(.easeIn))
                .animation(.easeIn(duration: 1.5), value: splashScreenHidden)
                .isHidden(splashScreenHidden, remove: true)
            }
            .onChange(of: scenePhase) { _, newValue in
                switch newValue {
                case .active:
                    manager.activate()
                case .background:
                    manager.deactivate()
                default:
                    break
                }
            }
        }
    }
}
