//
//  RegisterService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 15/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

class RegisterService {
    private let remote: RegisterRemoteService
    
    init(remote: RegisterRemoteService) {
        self.remote = remote
    }
    
    func register(details: RegisterDetails, completion: @escaping LoginRemoteService.LoginCompletion) {
        remote.register(details: details, completion: completion)
    }
}

