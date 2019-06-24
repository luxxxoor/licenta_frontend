//
//  LoginCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 07/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class LoginCoordinator: Coordinator {
    private let presenter: UINavigationController
    private let serviceProvider: ServiceProvider
    private let registerCoordinator: RegisterCoordinator
    private let firstLoginCoordinator: FirstLoginCoordinator
    private let tabBarCoordinator: TabBarCoordinator
    private let loginVC: LoginVC
    
    init(presenter: UINavigationController, serviceProvider: ServiceProvider) {
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.registerCoordinator = RegisterCoordinator(presenter: presenter, serviceProvider: serviceProvider)
        self.tabBarCoordinator = TabBarCoordinator(presenter: presenter, serviceProvider: serviceProvider)
        self.loginVC = LoginVC.instantiate()
        self.firstLoginCoordinator = FirstLoginCoordinator(presenter: presenter, serviceProvider: serviceProvider)
        
        self.loginVC.delegate = self
    }
    
    func start() {
        presenter.pushViewController(loginVC, animated: true)
    }
}

extension LoginCoordinator: LoginVCDelegate {
    func loginViewController(_ loginVC: LoginVC, didTapLogin details: LoginDetails) {
        serviceProvider.loginService.login(details: details) {
            [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                self.loginVC.showError(error)
                return
            }
            
            //self.tabBarCoordinator.start()
            self.firstLoginCoordinator.start()
        }
    }
    
    func loginViewControllerDidTapRegister(_ loginVC: LoginVC) {
        registerCoordinator.start()
    }
}
