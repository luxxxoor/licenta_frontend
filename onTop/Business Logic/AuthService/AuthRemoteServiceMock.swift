//
//  AuthRemoteServiceMock.swift
//  onTop
//
//  Created by Alexandru Vrincean on 01.02.2021.
//  Copyright © 2021 Alexandru Vrincean. All rights reserved.
//

import Foundation

struct AuthRemoteServiceMock: AuthRemoteService {
    private static var registered = false // in order to not change the protocol, we shall use static

    func register(firebaseToken: String, userInfo: UserInfo, completion: @escaping RegisterCompletion) {
        AuthRemoteServiceMock.registered = true
        completion(nil)
    }

    func login(firebaseToken: String, completion: @escaping LoginCompletion) {
        if AuthRemoteServiceMock.registered {
            completion(nil)
        } else {
            completion(AuthServiceError.userNotRegistered)
        }
    }
}
