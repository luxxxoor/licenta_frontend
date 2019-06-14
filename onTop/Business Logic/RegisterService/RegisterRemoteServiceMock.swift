//
//  RegisterRemoteServiceMock.swift
//  onTop
//
//  Created by Alexandru Vrincean on 15/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

class RegisterRemoteServiceMock : RegisterRemoteService {
    func register(details: RegisterDetails, completion: @escaping RegisterRemoteServiceMock.RegisterCompletion) {
        completion(nil)
    }
    
    func isAccountNameAvailable(details: RegisterDetails, completion: @escaping IsAccountNameAvailableCompletion) {
        completion(.success(true))
    }
}
