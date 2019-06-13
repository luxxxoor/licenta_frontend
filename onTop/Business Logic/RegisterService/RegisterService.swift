//
//  RegisterService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 15/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

class RegisterService {
    typealias CheckPasswords = (PasswordStatus) -> Void
    private let remote: RegisterRemoteService
    
    init(remote: RegisterRemoteService) {
        self.remote = remote
    }
    
    func register(details: RegisterDetails, completion: @escaping RegisterRemoteService.RegisterCompletion) {
        if details.password != details.repassword {
            let error = RegisterService.RegisterError.passwordsNotMatch
            completion(error)
            return
        }
        
        remote.register(details: details, completion: completion)
    }
    
    func checkPasswords(details: RegisterDetails, completion: CheckPasswords) {
        if details.password == "" || details.repassword == "" {
            completion(.notTheCase)
            return
        }
        
        completion(details.password == details.repassword ? .matching : .notMatching)
    }
    
    func isAccountNameAvailable(details: RegisterDetails, completion: @escaping RegisterRemoteService.IsAccountNameAvailableCompletion) {
        if (details.nickName?.count ?? 0) < 5 {
            completion(.failure(RegisterService.RegisterError.userNameTooShort))
            return
        }
        
        remote.isAccountNameAvailable(details: details, completion: completion)
    }
}

extension RegisterService {
    enum PasswordStatus {
        case matching
        case notTheCase
        case notMatching
    }
}

