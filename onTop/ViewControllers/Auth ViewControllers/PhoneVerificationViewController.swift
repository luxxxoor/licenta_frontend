//
//  PhoneVerificationViewController.swift
//  onTop
//
//  Created by Alexandru Vrincean on 01.02.2021.
//  Copyright © 2021 Alexandru Vrincean. All rights reserved.
//

import UIKit
import PhoneNumberKit

protocol PhoneVerificationViewControllerDelegate: AnyObject {
    func phoneVerificationViewController(didTapContinueWithPhoneNumber phoneNumber: String)
    func phoneVerificationViewController(didTapSocialMedia: String)
}

final class PhoneVerificationViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var phoneTextField: RoPhoneNumberTextField!

    // MARK: - Properties
    private let phoneNumberKit = PhoneNumberKit()
    weak var delegate: PhoneVerificationViewControllerDelegate?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupPhoneNumberTextField()
        setupToHideKeyboardOnTapOnView()
    }

    // MARK: - Utils
    private func isPhoneNumber(_ phoneNumber: String) -> Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: phoneNumber, options: [], range: NSRange(location: 0, length: phoneNumber.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == phoneNumber.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}

// MARK: - Setups

private extension PhoneVerificationViewController {

    private func setupPhoneNumberTextField() {
        phoneTextField.delegate = self

        phoneTextField.withFlag = true
        phoneTextField.withPrefix = true
        phoneTextField.withExamplePlaceholder = true
    }

    private func setupToHideKeyboardOnTapOnView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}

// MARK: - Actions

private extension PhoneVerificationViewController {
    @objc private func dismissKeyboard() {
        phoneTextField.resignFirstResponder()
    }

    @IBAction private func didChangeText(_ sender: UITextField) {
        guard let newText = sender.text, let _ = try? phoneNumberKit.parse(newText) else { return }

        phoneTextField.resignFirstResponder()
    }

    @IBAction private func didTapContinue(_ sender: UIButton) {
        guard let phoneNumber = phoneTextField.text?.trimmingCharacters(in: .whitespaces),
            isPhoneNumber(phoneNumber) else {
            #warning("Add pop up")
            return
        }

        delegate?.phoneVerificationViewController(didTapContinueWithPhoneNumber: phoneNumber)
    }

    @IBAction private func didTapSocialMedia(_ sender: UIButton) {
        delegate?.phoneVerificationViewController(didTapSocialMedia: phoneTextField.text!)
    }
}

// MARK: - UITextFieldDelegate

extension PhoneVerificationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField === phoneTextField else { return true }

        textField.resignFirstResponder()
        return true
    }
}

// MARK: - StoryboardViewController

extension PhoneVerificationViewController: StoryboardViewController {
    static func instantiate() -> Self {
        let storyboard: UIStoryboard = .auth
        guard let instance = storyboard.instantiateViewController(withIdentifier: "\(Self.self)") as? Self else {
            fatalError("Could not find \(Self.self)")
        }

        return instance
    }
}
