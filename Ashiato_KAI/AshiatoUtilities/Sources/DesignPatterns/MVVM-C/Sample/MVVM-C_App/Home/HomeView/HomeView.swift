//
//  HomeView.swift
//  MVVM-C_App
//
//  Created by Uedasoft IT Solutions on 01/04/25.
//

import SwiftUI

struct HomeView: View {
    @State
    var viewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack(spacing: 10) {
                Group {
                    Button("Push Home Details") {
                        viewModel.onPushHomeDetailsAction()
                    }
                    
                    Button("Push Home Sub Details") {
                        viewModel.onPushHomeSubDetailsAction()
                    }
                }
                .tertiaryButtonStyle()
            }
        }
        .navigationTitle("Home")
    }
}

extension View {
    @ViewBuilder
    func tertiaryButtonStyle() -> some View {
        self.frame(height: 40)
            .padding()
            .background(Color.blue.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
