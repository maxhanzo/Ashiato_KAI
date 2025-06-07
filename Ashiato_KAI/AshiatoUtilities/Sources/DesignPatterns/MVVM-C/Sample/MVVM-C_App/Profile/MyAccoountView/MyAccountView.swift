//
//  MyAccoountView.swift
//  MVVM-C_App
//
//  Created by Uedasoft IT Solutions on 01/04/25.
//

import SwiftUI

struct MyAccountView: View {
    @State
    var viewModel: MyAccountViewModel
        
    var body: some View {
        ZStack {
            Color.white
            
            VStack(spacing: 10) {
                Group {
                    Button("Pop To Profile") {
                        viewModel.onPopToProfileAction()
                    }
                    
                    Button("Pop To Root") {
                        viewModel.onPopToRootAction()
                    }
                    
                    Button("Dismiss Coordinator") {
                        viewModel.onDismiss()
                    }
                    
                    Button("Pop To Details") {
                        viewModel.onPopToDetailsAction()
                    }
                    
                    Button("Go To Sub Details") {
                        viewModel.onGoToSubDetailsAction()
                    }
                }
                .tertiaryButtonStyle()
            }
        }
        .navigationTitle("My Account")
    }
}
