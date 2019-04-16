//
//  LoginVC.swift
//  onTop
//
//  Created by Alexandru Vrincean on 07/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

protocol LoginVCDelegate: AnyObject {
    func loginViewController(_ loginVC: LoginVC, didTapLogin details: LoginDetails)
    func loginViewControllerDidTapRegister(_ loginVC: LoginVC)
}

class LoginVC: UIViewController {
    @IBOutlet private weak var accountNameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    weak var delegate: LoginVCDelegate?
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        guard let delegate = delegate, let accountName = accountNameField.text, let password = passwordField.text else { return }
        
        let details = LoginDetails(nickName: accountName, password: password)
        delegate.loginViewController(self, didTapLogin: details)
    }
    
    @IBAction func didTapRegister(_ sender: UIButton) {
        delegate?.loginViewControllerDidTapRegister(self)
    }
}

extension LoginVC: StoryboardViewController {
} 
