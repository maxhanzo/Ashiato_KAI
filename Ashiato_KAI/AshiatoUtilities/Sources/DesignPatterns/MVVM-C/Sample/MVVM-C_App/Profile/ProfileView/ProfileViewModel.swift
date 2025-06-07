//
//  ProfileViewModel.swift
//  MVVM-C_App
//
//  Created by Uedasoft IT Solutions on 01/04/25.
//

import DesignPatterns

class ProfileViewModel: ViewModel<ProfileCoordinator> {
    func onPushMyAccountAction() {
        coordinator?.showMyAccount()
    }
    
    func onPopToHomeSubDetailsAction() {
        coordinator?.backToSubDetails()
    }
}
