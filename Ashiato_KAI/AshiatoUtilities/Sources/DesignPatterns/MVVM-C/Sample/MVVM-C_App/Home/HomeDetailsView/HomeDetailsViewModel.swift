//
//  HomeDetailsViewModel.swift
//  MVVM-C_App
//
//  Created by Uedasoft IT Solutions on 01/04/25.
//

import DesignPatterns

class HomeDetailsViewModel: ViewModel<HomeCoordinator> {
    func onPopHomeAction() {
        coordinator?.pop()
    }
    
    func onPushHomeSubDetailsAction() {
        coordinator?.showSubDetail()
    }
}
