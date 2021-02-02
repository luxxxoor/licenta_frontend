//
//  RegistrationViewController.swift
//  onTop
//
//  Created by Alexandru Vrincean on 01.02.2021.
//  Copyright © 2021 Alexandru Vrincean. All rights reserved.
//

import Foundation

import UIKit

protocol RegistrationViewControllerDelegate: AnyObject {
    func registrationViewControllerDidSendRegister(withUserInfo userInfo: UserInfo)
}

final class RegistrationViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var registerButton: UIButton!

    // MARK: - Propertiess
    private var completed: (firstName: Bool, lastName: Bool, email: Bool) = (false, false, false) {
        didSet {
            if completed == (true, true, true) {
                registerButton.isEnabled = true
            } else {
                registerButton.isEnabled = false
            }
        }
    }
    weak var delegate: RegistrationViewControllerDelegate?
}

// MARK: - Actions

private extension RegistrationViewController {
    @IBAction private func didTapRegister(_ sender: UIButton) {
        let userInfo = UserInfo(name: nameTextField.text!, email: emailTextField.text!)
        delegate?.registrationViewControllerDidSendRegister(withUserInfo: userInfo)
    }

    @IBAction private func didChangeText(_ sender: UITextField) {
        if sender === nameTextField {
            completed.firstName = getText(sender.text) != nil
        }
        if sender === emailTextField {
            completed.email = getText(sender.text) != nil
        }
    }

    private func getText(_ text: String?) -> String? {
        guard let text = text, !text.isEmpty else {
            return nil
        }

        return text
    }
}

// MARK: - StoryboardViewController

extension RegistrationViewController: StoryboardViewController {
    static func instantiate() -> Self {
        let storyboard: UIStoryboard = .auth
        guard let instance = storyboard.instantiateViewController(withIdentifier: "\(Self.self)") as? Self else {
            fatalError("Could not find \(Self.self)")
        }

        return instance
    }
}
