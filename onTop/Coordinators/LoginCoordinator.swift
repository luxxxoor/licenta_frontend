//
//  LoginCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 07/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class LoginCoordinator {
    private let presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let loginVC = LoginVC.instantiate()
        loginVC.delegate = self
        presenter.pushViewController(loginVC, animated: true)
    }
}

extension LoginCoordinator: LoginVCDelegate {
    
}
