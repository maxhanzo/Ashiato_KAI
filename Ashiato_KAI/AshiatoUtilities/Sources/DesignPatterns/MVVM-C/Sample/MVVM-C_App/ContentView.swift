//
//  ContentView.swift
//  MVVM-C_App
//
//  Created by Uedasoft IT Solutions on 31/05/25.
//

import DesignPatterns
import SwiftUI

struct ContentView: View {
    @State
    var path: [AnyHashable] = []
    
    var body: some View {
        HomeCoordinator(
            path: $path,
            profileCoordinator: ProfileCoordinator(path: $path)
        )
    }
}

#Preview {
    ContentView()
}
