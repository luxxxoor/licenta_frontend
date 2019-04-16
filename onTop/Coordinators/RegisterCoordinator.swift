//
//  RegisterCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 15/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class RegisterCoordinator: Coordinator {
    private let presenter: UINavigationController
    private let serviceProvider: ServiceProvider
    private let registerVC: RegisterVC
    
    init(presenter: UINavigationController, serviceProvider: ServiceProvider) {
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.registerVC = RegisterVC.instantiate()
        
        self.registerVC.delegate = self
    }
    
    func start() {
        presenter.pushViewController(registerVC, animated: true)
    }
}

extension RegisterCoordinator: RegisterVCDelegate {
    func registerViewController(_ registerVC: RegisterVC, didTapRegister details: RegisterDetails) {
        serviceProvider.registerService.register(details: details) {
            [unowned self] error in
            
            if let error = error {
                registerVC.showError(error)
                return
            } else {
                self.presenter.popViewController(animated: true)
            }
        }
    }
    
}

