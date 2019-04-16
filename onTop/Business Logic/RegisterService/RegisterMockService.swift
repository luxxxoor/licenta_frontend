//
//  RegisterMockService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 15/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

class RegisterMockService : RegisterRemoteService {
    func register(details: RegisterDetails, completion: @escaping RegisterMockService.RegisterCompletion) {
        completion(nil)
    }
}
