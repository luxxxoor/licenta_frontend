//
//  ChangeEmailCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 04/07/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class ChangeEmailCoordinator: Coordinator {
    private let presenter: UINavigationController
    private let changeEmailVC: ChangeEmailVC
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.changeEmailVC = ChangeEmailVC.instantiate()
    }
    
    func start() {
        presenter.pushViewController(changeEmailVC, animated: true)
    }
}
