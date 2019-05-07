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
        case alreadyExistingUserException
        case passwordsNotMatch
        case passwordTooShort
        case userNameTooShort
        
        var errorDescription: String? {
            switch self {
            case .serverError:
                return "There was a server error. Operation was canceled."
            case .alreadyExistingUserException:
                return "An user with your picked nickname already exists."
            case .passwordsNotMatch:
                return "Provided passwords do not match."
            case .passwordTooShort:
                return "Password has to be at least 5 characters long."
            case .userNameTooShort:
                return "UserName has to be at least 5 characters long."
            }
        }
    }
}
