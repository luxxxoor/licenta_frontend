//
//  RegisterCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 15/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class RegisterCoordinator: Coordinator {
    private let presenter: UINavigationController
    private let serviceProvider: ServiceProvider
    private let registerVC: RegisterVC
    private var registerDetails: RegisterDetails
    
    init(presenter: UINavigationController, serviceProvider: ServiceProvider) {
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.registerVC = RegisterVC.instantiate()
        self.registerDetails = RegisterDetails(nickName: nil, password: nil, repassword: nil, email: nil)
        
        self.registerVC.delegate = self
    }
    
    func start() {
        presenter.pushViewController(registerVC, animated: true)
    }
}

extension RegisterCoordinator: RegisterVCDelegate {
    func registerViewController(_ registerVC: RegisterVC, didTapRegister details: RegisterDetails) {
        serviceProvider.registerService.register(details: details) {
            [weak self] error in
            
            if let error = error {
                if error is RegisterService.RegisterError {
                    registerVC.resetPasswordFields()
                }
                registerVC.showError(error)
            } else {
                self?.presenter.popViewController(animated: true)
            }
        }
    }
    
    func registerViewControllerDidTapBack(_ registerVC: RegisterVC) {
        presenter.popViewController(animated: true)
    }
    
    func registerViewController(_ registerVC: RegisterVC, didEditAccountName accountName: String) {
        guard !accountName.isEmpty else {
            self.registerVC.accountNameErrorLabel.isHidden = true
            return
        }
        
        registerDetails = RegisterDetails(nickName: accountName, password: registerDetails.password, repassword: registerDetails.repassword, email: registerDetails.email)
        
        serviceProvider.registerService.isAccountNameAvailable(details: registerDetails) {
            [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(availability):
                if availability == true {
                    self.registerVC.accountNameErrorLabel.isHidden = true
                } else {
                    self.registerVC.accountNameErrorLabel.text = Constants.accountNameAlreadyInUser
                    self.registerVC.accountNameErrorLabel.isHidden = false
                }
            case let .failure(error):
                if let error = error as? RegisterService.RegisterError,
                    case .userNameTooShort = error {
                    self.registerVC.accountNameErrorLabel.text = Constants.userNameTooShortMessage
                    self.registerVC.accountNameErrorLabel.isHidden = false
                }
            }
        }
    }
    
    func registerViewController(_ registerVC: RegisterVC, didEditPassword password: String) {
        registerDetails = RegisterDetails(nickName: registerDetails.nickName, password: password, repassword: registerDetails.repassword, email: registerDetails.email)
        
        checkPassowrds()
    }
    
    func registerViewController(_ registerVC: RegisterVC, didEditRepassowrd repassword: String) {
        registerDetails = RegisterDetails(nickName: registerDetails.nickName, password: registerDetails.password, repassword: repassword, email: registerDetails.email)
        
        checkPassowrds()
    }
    
    private func checkPassowrds() {
        serviceProvider.registerService.checkPasswords(details: registerDetails) {
            [weak self] passwordStatus in
            guard let self = self else { return }
            
            self.registerVC.passwordErrorLabel.isHidden = passwordStatus == .notMatching ? false : true
        }
    }
}

private extension RegisterCoordinator {
    enum Constants {
        static let userNameTooShortMessage = "Account Name should have at least 5 characters !"
        static let accountNameAlreadyInUser = "Account Name already in use !"
    }
}
