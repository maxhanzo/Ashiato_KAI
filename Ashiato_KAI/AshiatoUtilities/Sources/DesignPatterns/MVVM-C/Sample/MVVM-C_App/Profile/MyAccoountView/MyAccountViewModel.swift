//
//  MyAccountViewModel.swift
//  MVVM-C_App
//
//  Created by Uedasoft IT Solutions on 01/04/25.
//

import DesignPatterns

class MyAccountViewModel: ViewModel<ProfileCoordinator> {
    func onPopToProfileAction() {
        coordinator?.popToRoot()
    }
    
    func onPopToDetailsAction() {
        coordinator?.backToDetails()
    }
    
    func onPopToRootAction() {
        coordinator?.popToRoot()
    }
    
    func onGoToSubDetailsAction() {
        coordinator?.backToSubDetails()
    }
    
    func onDismiss() {
        coordinator?.onCompletion()
    }
}
