//
//  ChangePasswordCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 04/07/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class ChangePasswordCoordinator: Coordinator {
    private let presenter: UINavigationController
    private let changePassowrdVC: ChangePasswordVC
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.changePassowrdVC = ChangePasswordVC.instantiate()
    }
    
    func start() {
        presenter.pushViewController(changePassowrdVC, animated: true)
    }
}
