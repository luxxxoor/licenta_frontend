//
//  RegisterVC.swift
//  onTop
//
//  Created by Alexandru Vrincean on 07/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

protocol RegisterVCDelegate: AnyObject {
    func registerViewController(_ registerVC: RegisterVC, didTapRegister details: RegisterDetails)
    func registerViewControllerDidTapBack(_ registerVC: RegisterVC)
    func registerViewController(_ registerVC: RegisterVC, didEditAccountName accountName: String)
    func registerViewController(_ registerVC: RegisterVC, didEditPassword password: String)
    func registerViewController(_ registerVC: RegisterVC, didEditRepassowrd repassword: String)
}

class RegisterVC: UIViewController, StoryboardViewController {
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var accountNameField: UITextField!
    @IBOutlet private weak var accountEmailField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var repasswordField: UITextField!
    @IBOutlet weak var accountNameErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    weak var delegate: RegisterVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        backButton.setImage(#imageLiteral(resourceName: "right_arrow-icon"), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        backButton.titleLabel?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        backButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    @IBAction private func didTapRegister(_ sender: UIButton) {
        guard let delegate = delegate,
            let accountName = accountNameField.text,
            let email = accountEmailField.text,
            let password = passwordField.text,
            let repassword = repasswordField.text
            else { return }
        
        let details = RegisterDetails(nickName: accountName,
                                      password: password,
                                      repassword: repassword,
                                      email: email)
        
        delegate.registerViewController(self, didTapRegister: details)
    }
    
    @IBAction private func didTapBack(_ sender: UIButton) {
        delegate?.registerViewControllerDidTapBack(self)
    }
    
    @IBAction private func didEditAccountName(_ sender: UITextField) {
        guard let accountName = sender.text else { return }
        delegate?.registerViewController(self, didEditAccountName: accountName)
    }
    
    @IBAction private func didEditPassowrd(_ sender: UITextField) {
        guard let password = sender.text else { return }
        delegate?.registerViewController(self, didEditPassword: password)
    }
    
    @IBAction private func didEditRepassword(_ sender: UITextField) {
        guard let repassword = sender.text else { return }
        delegate?.registerViewController(self, didEditRepassowrd: repassword)
    }
    
    
    func resetPasswordFields() {
        passwordField.text = ""
        repasswordField.text = ""
        passwordErrorLabel.isHidden = true
    }
}
