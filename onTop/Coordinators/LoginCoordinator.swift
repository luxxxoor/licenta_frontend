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
    private let loginVC: LoginVC
    
    
    init(presenter: UINavigationController, serviceProvider: ServiceProvider) {
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.registerCoordinator = RegisterCoordinator(presenter: presenter, serviceProvider: serviceProvider)
        self.loginVC = LoginVC.instantiate()
        
        self.loginVC.delegate = self
    }
    
    func start() {
        presenter.pushViewController(loginVC, animated: true)
    }
}

extension LoginCoordinator: LoginVCDelegate {
    func loginViewController(_ loginVC: LoginVC, didTapLogin details: LoginDetails) {
        serviceProvider.loginService.login(details: details) {
            [unowned self] error in
            
            if let error = error {
                self.loginVC.showError(error)
                return
            }
            print("connected")
        }
    }
    
    func loginViewControllerDidTapRegister(_ loginVC: LoginVC) {
        registerCoordinator.start()
    }
    
    
}
