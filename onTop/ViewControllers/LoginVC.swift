//
//  LoginVC.swift
//  onTop
//
//  Created by Alexandru Vrincean on 07/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

protocol LoginVCDelegate: AnyObject {
    //func loginViewController(_ loginVC: LoginVC, didTapLogin phoneNumber: String)
}

class LoginVC: UIViewController {
    weak var delegate: LoginVCDelegate?
}

extension LoginVC: StoryboardViewController {
}
