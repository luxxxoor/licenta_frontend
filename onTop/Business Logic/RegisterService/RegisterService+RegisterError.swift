//
//  RegisterService+RegisterError.swift
//  onTop
//
//  Created by Alexandru Vrincean on 15/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

extension RegisterService {
    
    enum RegisterError: LocalizedError {
        case serverError
        case alreadyExistingUserException(message: String)
        case passwordsNotMatch
        case passwordTooShort(message: String)
        case userNameTooShort
        
        var errorDescription: String? {
            switch self {
            case .serverError:
                return "There was a server error. Operation was canceled."
            case .alreadyExistingUserException(let message):
                return message
            case .passwordsNotMatch:
                return "Provided passwords do not match."
            case .passwordTooShort(let message):
                return message
            case .userNameTooShort:
                return "UserName has to be at least 5 characters long."
            }
        }
    }
}
