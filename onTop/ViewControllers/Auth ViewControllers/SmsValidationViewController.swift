//
//  SmsValidationViewController.swift
//  onTop
//
//  Created by Alexandru Vrincean on 01.02.2021.
//  Copyright © 2021 Alexandru Vrincean. All rights reserved.
//

import UIKit

protocol SmsValidationViewControllerDelegate: AnyObject {
    func smsValidationViewController(didEnterCode code: String, failure: @escaping () -> Void)
}

final class SmsValidationViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var codeInputView: CodeInputView!

    // MARK: - Properties
    weak var delegate: SmsValidationViewControllerDelegate?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        codeInputView.codeInputDelegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        codeInputView.becomeFirstResponder()
    }
}

// MARK: - CodeInputViewDelegate

extension SmsValidationViewController: CodeInputViewDelegate {
    func codeInputView(_ codeInputView: CodeInputView, didFinishWithCode code: String) {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            guard let self = self else { return }

            self.codeInputView.alpha = 0.2
            self.codeInputView.resignFirstResponder()
        })

        delegate?.smsValidationViewController(didEnterCode: code) {
            codeInputView.clear()

            UIView.animate(withDuration: 0.2, animations: {
                codeInputView.alpha = 1
                codeInputView.shake()
                codeInputView.becomeFirstResponder()
            })
        }
    }
}

// MARK: - Utils

private extension UIView {
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - 10, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + 10, y: center.y))
        layer.add(animation, forKey: "position")
    }
}

// MARK: - StoryboardViewController

extension SmsValidationViewController: StoryboardViewController {
    static func instantiate() -> Self {
        let storyboard: UIStoryboard = .auth
        guard let instance = storyboard.instantiateViewController(withIdentifier: "\(Self.self)") as? Self else {
            fatalError("Could not find \(Self.self)")
        }

        return instance
    }
}
