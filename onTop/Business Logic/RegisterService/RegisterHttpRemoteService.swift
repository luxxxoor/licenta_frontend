//
//  RegisterRemoteServiceReal.swift
//  onTop
//
//  Created by Alexandru Vrincean on 15/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RegisterRemoteServiceReal: RegisterRemoteService {
    func register(details: RegisterDetails, completion: @escaping RegisterRemoteServiceReal.RegisterCompletion) {
        let parameters = ["nickName" : details.nickName, "password" : details.password, "email" : details.email]
        let headers = ["Content-Type" : "application/json"]
        
        Alamofire.request(Constants.registerUrl, method: .post, parameters: parameters as Parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            
            guard let statusCode = response.response?.statusCode else { return }
            
            if statusCode == 200 {
                DispatchQueue.main.async { completion(nil) }
            } else {
                if let result = response.result.value {
                    if let errors = JSON(result)["errors"].array {
                        let exception = errors[0].stringValue
                        let message = errors[1].stringValue
                        
                        if exception == Constants.passwordTooShortException {
                            let error = RegisterService.RegisterError.passwordTooShort(message: message)
                            DispatchQueue.main.async { completion(error) }
                        } else if exception == Constants.alreadyExistingUserException {
                            let error = RegisterService.RegisterError.alreadyExistingUserException(message: message)
                            DispatchQueue.main.async { completion(error) }
                        } else {
                            let error = RegisterService.RegisterError.serverError
                            DispatchQueue.main.async { completion(error) }
                        }
                    } else {
                        completion(LoginService.LoginError.serverError)
                    }
                }
            }
        }
    }
    
    func isAccountNameAvailable(details: RegisterDetails, completion: @escaping IsAccountNameAvailableCompletion) {
        guard let nickName = details.nickName else { return }
        
        let parameters = ["nickName": nickName]
        let headers = ["Content-Type" : "application/json"]
        
        Alamofire.request(Constants.checkAccountNameUrl, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: headers)
            .responseJSON {
                response in
                
                guard let statusCode = response.response?.statusCode else { return }
                
                if statusCode == 200 {
                    DispatchQueue.main.async { completion(.success(true)) }
                } else if statusCode == 403 {
                    DispatchQueue.main.async { completion(.success(false)) }
                } else {
                    let error = RegisterService.RegisterError.serverError
                    DispatchQueue.main.async { completion(.failure(error)) }
                }
        }
    }
}

extension RegisterRemoteServiceReal {
    enum Constants {
        static let registerUrl = "http://localhost:8604/user/registration/v1/register/"
        static let checkAccountNameUrl = "http://localhost:8604/user/management/v1/name-availability"
        static let passwordTooShortException = "com.licenta.usm.Exceptions.PasswordTooShortException"
        static let alreadyExistingUserException = "com.licenta.usm.Exceptions.AlreadyExistingUserException"
    }
}
