//
//  HomeDetailsView.swift
//  MVVM-C_App
//
//  Created by Uedasoft IT Solutions on 01/04/25.
//

import SwiftUI

struct HomeDetailsView: View {
    @State
    var viewModel: HomeDetailsViewModel
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack(spacing: 10) {
                Group {
                    Button("Pop Home") {
                        viewModel.onPopHomeAction()
                    }
                    
                    Button("Push Home Sub Details") {
                        viewModel.onPushHomeSubDetailsAction()
                    }
                }
                .tertiaryButtonStyle()
            }
        }
        .navigationTitle("Home Details")
    }
}
