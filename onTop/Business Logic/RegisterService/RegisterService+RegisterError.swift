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
        case forbidden(reason: String)
        case serverError
        
        var errorDescription: String? {
            switch self {
            case .forbidden(let reason):
                return reason
            case .serverError:
                return "There was a server error. Operation was canceled."
            }
        }
    }
}
