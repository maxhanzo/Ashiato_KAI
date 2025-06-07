//
//  ProfileView.swift
//  MVVM-C_App
//
//  Created by Uedasoft IT Solutions on 01/04/25.
//

import SwiftUI

struct ProfileView: View {
    @State
    var viewModel: ProfileViewModel
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack(spacing: 10) {
                Group {
                    Button("Push My Account") {
                        viewModel.onPushMyAccountAction()
                    }
                    
                    Button("Pop To Home Sub Details") {
                        viewModel.onPopToHomeSubDetailsAction()
                    }
                }
                .tertiaryButtonStyle()
            }
        }
        .navigationTitle("Profile")
    }
}
