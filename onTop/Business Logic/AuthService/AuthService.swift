//
//  AuthService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 01.02.2021.
//  Copyright © 2021 Alexandru Vrincean. All rights reserved.
//

import Foundation

final class AuthService {
    private let remote: AuthRemoteService

    init(remote: AuthRemoteService) {
        self.remote = remote
    }

    func login(firebaseToken: String, completion: @escaping AuthRemoteService.LoginCompletion) {
        remote.login(firebaseToken: firebaseToken, completion: completion)
    }

    func register(firebaseToken: String, userInfo: UserInfo, completion: @escaping AuthRemoteService.RegisterCompletion) {
        remote.register(firebaseToken: firebaseToken, userInfo: userInfo, completion: completion)
    }
}

// MARK: - Error

enum AuthServiceError: LocalizedError {
    case userNotRegistered, alreadyCreated, invalidToken, other(error: Error)

    var errorDescription: String? {
        switch self {
        case .userNotRegistered:
            return "User account is not registered."
        case .alreadyCreated:
            return "User account is already created."
        case .invalidToken:
            return "Invalid token provided."
        case .other(let error):
            return error.localizedDescription
        }
    }
}

