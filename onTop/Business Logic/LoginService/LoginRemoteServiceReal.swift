//
//  LoginHttpRemoteService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 08/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation
import Alamofire

class LoginRemoteServiceReal: LoginRemoteService {
    func login(details: LoginDetails, completion: @escaping LoginRemoteService.LoginCompletion) {
        let parameters = ["username" : details.userName, "password" : details.password]
        let headers = ["Content-Type" : "application/json"]
        
        Alamofire.request(Constants.loginUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            
            guard let statusCode = response.response?.statusCode else { return }
            
            if statusCode == 200 {
                DispatchQueue.main.async { completion(nil) }
            } else if statusCode == 401 {
                let error = LoginService.LoginError.unauthorized
                DispatchQueue.main.async { completion(error) }
            } else {
                let error = LoginService.LoginError.serverError
                DispatchQueue.main.async { completion(error) }
            }
        }
    }
}

extension LoginRemoteServiceReal {
    enum Constants {
        static let loginUrl = "\(LoginRemoteServiceConstants.address)/auth/"
    }
}
