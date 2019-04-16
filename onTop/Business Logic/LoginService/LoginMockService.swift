//
//  LoginMockService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 08/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

class LoginMockService : LoginRemoteService {
    let users: [LoginDetails] = [LoginDetails(nickName: "testuser", password: "password")]
    
    func login(details: LoginDetails, completion: @escaping LoginMockService.LoginCompletion) {
        users.forEach {
            if $0.nickName == details.nickName && $0.password == details.password {
                completion(nil)
                return
            }
        }
        
        completion(LoginService.LoginError.unauthorized)
    }
}
