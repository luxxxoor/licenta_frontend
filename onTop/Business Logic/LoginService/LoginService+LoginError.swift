//
//  LoginService+LoginError.swift
//  onTop
//
//  Created by Alexandru Vrincean on 08/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

extension LoginService {
    
    enum LoginError: LocalizedError {
        case unauthorized
        case serverError
        
        var errorDescription: String? {
            switch self {
            case .unauthorized:
                return "Invalid user or password."
            case .serverError:
                return "There was a server error. Operation was canceled."
            }
        }
    }
}
