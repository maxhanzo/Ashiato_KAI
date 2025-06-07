//
//  HomeViewModel.swift
//  MVVM-C_App
//
//  Created by Uedasoft IT Solutions on 01/04/25.
//

import DesignPatterns

class HomeViewModel: ViewModel<HomeCoordinator> {    
    func onPushHomeDetailsAction() {
        coordinator?.showDetail()
    }
    
    func onPushHomeSubDetailsAction() {
        coordinator?.showSubDetail()
    }
}
