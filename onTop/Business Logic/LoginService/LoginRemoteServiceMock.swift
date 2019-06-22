//
//  LoginRemoteServiceMock.swift
//  onTop
//
//  Created by Alexandru Vrincean on 08/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

class LoginRemoteServiceMock : LoginRemoteService {
    let users: [LoginDetails] = [LoginDetails(userName: "testuser", password: "password")]
    
    func login(details: LoginDetails, completion: @escaping LoginRemoteServiceMock.LoginCompletion) {
        if users.firstIndex(where: { $0.userName == details.userName && $0.password == details.password }) != nil {
            completion(nil)
        } else {
            completion(LoginService.LoginError.unauthorized)
        }
    }
}
