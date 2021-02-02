//
//  RegistrationCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 01.02.2021.
//  Copyright © 2021 Alexandru Vrincean. All rights reserved.
//

import UIKit

protocol RegistrationCoordinatorDelegate: AnyObject {
    func registrationCoordinatorDidComplete()
}

final class RegistrationCoordinator: Coordinator {
    private let authService: AuthService
    private let presenter: UINavigationController
    private let registrationVC : RegistrationViewController
    private let fireabseToken: String
    private let delegate: RegistrationCoordinatorDelegate

    init(
        presenter: UINavigationController,
        firebaseToken: String,
        authService: AuthService,
        delegate: RegistrationCoordinatorDelegate
    ) {
        self.authService = authService
        self.presenter = presenter
        self.registrationVC = RegistrationViewController.instantiate()
        self.fireabseToken = firebaseToken
        self.delegate = delegate

        self.registrationVC.delegate = self
    }

    func start() {
        presenter.pushViewController(registrationVC, animated: true)
    }
}

extension RegistrationCoordinator: RegistrationViewControllerDelegate {
    func registrationViewControllerDidSendRegister(withUserInfo userInfo: UserInfo) {
        authService.register(firebaseToken: fireabseToken, userInfo: userInfo) { [weak self] error in
            guard let self = self else { return }

            if let error = error {
                fatalError(error.localizedDescription)
            } else {
                self.authService.login(firebaseToken: self.fireabseToken) { [weak self] error in
                    guard let self = self else { return }

                    if let error = error {
                        self.presenter.showError(error)
                    }

                    self.delegate.registrationCoordinatorDidComplete()
                }
            }
        }
    }
}

