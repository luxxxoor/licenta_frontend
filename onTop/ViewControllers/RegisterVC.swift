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
}

class RegisterVC: UIViewController {
    @IBOutlet private weak var accountNameField: UITextField!
    @IBOutlet private weak var accountEmailField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var repasswordField: UITextField!
    weak var delegate: RegisterVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapRegister(_ sender: UIButton) {
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
}

extension RegisterVC: StoryboardViewController {
}
