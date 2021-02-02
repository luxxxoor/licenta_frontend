//
//  SmsValidationCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 01.02.2021.
//  Copyright © 2021 Alexandru Vrincean. All rights reserved.
//

import UIKit

protocol SmsValidationCoordinatorDelegate: AnyObject {
    func smsValidationCoordinator(presentingVC: UIViewController, didGetToken token: String)
}

final class SmsValidationCoordinator: Coordinator {
    private let phoneService: PhoneService
    private let presenter: UINavigationController
    private let smsValidationViewController: SmsValidationViewController
    private let delegate: SmsValidationCoordinatorDelegate

    init(presenter: UINavigationController, phoneService: PhoneService, delegate: SmsValidationCoordinatorDelegate) {
        self.presenter = presenter
        self.phoneService = phoneService
        self.smsValidationViewController = SmsValidationViewController.instantiate()
        self.delegate = delegate
        self.smsValidationViewController.delegate = self
    }

    func start() {
        smsValidationViewController.preferredContentSize = CGSize(width: 200, height: 100)
        presenter.definesPresentationContext = true
        presenter.present(smsValidationViewController, animated: true)
    }
}

extension SmsValidationCoordinator: SmsValidationViewControllerDelegate {
    func smsValidationViewController(didEnterCode code: String, failure: @escaping () -> Void) {
        phoneService.signIn(verificationCode: code) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .failure(_/*let error*/):
                failure()
            case .success(let firebaseToken):
                self.presenter.dismiss(animated: true) { [self] in
                    self.delegate.smsValidationCoordinator(
                        presentingVC: self.smsValidationViewController,
                        didGetToken: firebaseToken
                    )
                }
            }
        }
    }
}


