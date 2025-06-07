//
//  HomeSubDetailsViewModel.swift
//  MVVM-C_App
//
//  Created by Uedasoft IT Solutions on 01/04/25.
//

import DesignPatterns

class HomeSubDetailsViewModel: ViewModel<HomeCoordinator> {
    func onPopToRootAction() {
        coordinator?.popToRoot()
    }
    
    func onPushProfileAction() {
        coordinator?.showProfile()
    }
    
    func onPresentProfileAction() {
        coordinator?.presentProfile()
    }
}
