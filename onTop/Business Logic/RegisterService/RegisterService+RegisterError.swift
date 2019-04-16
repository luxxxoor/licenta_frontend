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
        case forbidden
        case serverError
        case passwordsNotMatch
        
        var errorDescription: String? {
            switch self {
            case .forbidden:
                return "An user with your picked nickname already exists."
            case .serverError:
                return "There was a server error. Operation was canceled."
            case .passwordsNotMatch:
                return "Provided passwords do not match."
            }
        }
    }
}
