//
//  RegisterRemoteService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 15/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

protocol RegisterRemoteService {
    typealias RegisterCompletion = (Error?) -> Void
    
    func register(details: RegisterDetails, completion: @escaping RegisterCompletion)
}

struct RegisterRemoteServiceConstants {
    static let address = "http://localhost:8604"
}
