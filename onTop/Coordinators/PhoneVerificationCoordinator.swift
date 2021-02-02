//
//  PhoneVerificationCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 01.02.2021.
//  Copyright © 2021 Alexandru Vrincean. All rights reserved.
//

import UIKit

protocol PhoneVerificationCoordinatorDelegate: AnyObject {
    func phoneVerificationCoordinatorDidComplete()
}

final class PhoneVerificationCoordinator: Coordinator {
    private let phoneService = PhoneService(remote: PhoneRemoteServiceReal())
    private let presenter: UINavigationController
    private let phoneVerificationVC : PhoneVerificationViewController
    private let delegate: PhoneVerificationCoordinatorDelegate
    private var smsCoordinator: SmsValidationCoordinator?
    private var registrationCoordinator: RegistrationCoordinator?

    init(presenter: UINavigationController, delegate: PhoneVerificationCoordinatorDelegate) {
        self.presenter = presenter
        self.phoneVerificationVC = PhoneVerificationViewController.instantiate()
        self.delegate = delegate
        phoneVerificationVC.delegate = self
    }

    func start() {
        if presenter.viewControllers.count == 0 {
            presenter.pushViewController(phoneVerificationVC, animated: true)
        } else {
            var vcs = presenter.viewControllers
            vcs.insert(phoneVerificationVC, at: 0)
            presenter.viewControllers = vcs

            presenter.popToViewController(phoneVerificationVC, animated: true)
        }
    }
}

extension PhoneVerificationCoordinator: PhoneVerificationViewControllerDelegate {
    func phoneVerificationViewController(didTapContinueWithPhoneNumber phoneNumber: String) {
        phoneService.verifyPhoneNumber(phoneNumber) { [weak self] success in
            guard let self = self else { return }

            self.smsCoordinator = SmsValidationCoordinator(
                presenter: self.presenter,
                phoneService: self.phoneService,
                delegate: self
            )
            self.smsCoordinator?.start()
        }
    }

    func phoneVerificationViewController(didTapSocialMedia verificationCode: String) {
    }
}

// MARK: - SmsValidationCoordinatorDelegate

extension PhoneVerificationCoordinator: SmsValidationCoordinatorDelegate {
    func smsValidationCoordinator(presentingVC: UIViewController, didGetToken token: String) {
        let authService = AuthService(remote: AuthRemoteServiceReal())
        authService.login(firebaseToken: token) { [weak self] error in
            guard let self = self else { return }

            presentingVC.dismiss(animated: true)
            if let error = error {
                switch error {
                case .userNotRegistered:
                    self.registrationCoordinator = RegistrationCoordinator(
                        presenter: self.presenter,
                        firebaseToken: token,
                        authService: authService,
                        delegate: self
                    )
                    self.registrationCoordinator?.start()
                case .other(let error):
                    fatalError(error.localizedDescription)
                default: fatalError(error.localizedDescription)
                }
            } else {
                self.delegate.phoneVerificationCoordinatorDidComplete()
            }
        }
    }
}

// MARK: - RegistrationCoordinatorDelegate

extension PhoneVerificationCoordinator: RegistrationCoordinatorDelegate {
    func registrationCoordinatorDidComplete() {
        delegate.phoneVerificationCoordinatorDidComplete()
    }
}
