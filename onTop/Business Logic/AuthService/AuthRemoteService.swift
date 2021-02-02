//
//  AuthRemoteService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 01.02.2021.
//  Copyright © 2021 Alexandru Vrincean. All rights reserved.
//

import Foundation

protocol AuthRemoteService {
    typealias RegisterCompletion = (AuthServiceError?) -> Void
    typealias LoginCompletion = (AuthServiceError?) -> Void

    func register(firebaseToken: String, userInfo: UserInfo, completion: @escaping RegisterCompletion)
    func login(firebaseToken: String, completion: @escaping LoginCompletion)
}
