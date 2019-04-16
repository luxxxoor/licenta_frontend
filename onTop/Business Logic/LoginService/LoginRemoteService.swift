//
//  LoginRemoteService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 08/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

protocol LoginRemoteService {
    typealias LoginCompletion = (Error?) -> Void
    
    func login(details: LoginDetails, completion: @escaping LoginCompletion)
}

struct LoginRemoteServiceConstants {
        static let address = "http://localhost:8604/"
}
