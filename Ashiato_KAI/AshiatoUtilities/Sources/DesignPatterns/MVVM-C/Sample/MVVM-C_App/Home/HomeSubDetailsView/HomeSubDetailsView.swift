//
//  HomeSubDetailsView.swift
//  MVVM-C_App
//
//  Created by Uedasoft IT Solutions on 01/04/25.
//

import SwiftUI

struct HomeSubDetailsView: View {
    @State
    var viewModel: HomeSubDetailsViewModel
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack(spacing: 10) {
                Group {
                    Button("Pop To Root") {
                        viewModel.onPopToRootAction()
                    }
                    
                    Button("Push Profile") {
                        viewModel.onPushProfileAction()
                    }
                    
                    Button("Present Profile") {
                        viewModel.onPresentProfileAction()
                    }
                }
                .tertiaryButtonStyle()
            }
        }
        .navigationTitle("Home Sub Details")
    }
}
