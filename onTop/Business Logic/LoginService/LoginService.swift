//
//  LoginService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 08/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

class LoginService {
    private let remote: LoginRemoteService
    
    init(remote: LoginRemoteService) {
        self.remote = remote
    }
    
    func login(details: LoginDetails, completion: @escaping LoginRemoteService.LoginCompletion) {
        remote.login(details: details, completion: completion)
    }
}
