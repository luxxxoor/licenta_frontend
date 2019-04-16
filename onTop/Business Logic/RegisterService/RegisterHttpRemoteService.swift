//
//  RegisterHttpRemoteService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 15/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation
import Alamofire

class RegisterHttpRemotService: RegisterRemoteService {
    func register(details: RegisterDetails, completion: @escaping RegisterHttpRemotService.RegisterCompletion) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(Constants.registerUrl, method: .post, parameters: details, encoder: JSONEncoding.default as! ParameterEncoder, headers: headers).responseJSON {
            response in
            
            guard let statusCode = response.response?.statusCode else { print("escaping without status code #1"); return }
            
            if statusCode == 200 {
                completion(nil)
            } else if statusCode == 403 {
                completion(RegisterService.RegisterError.forbidden(reason: ""))
            } else {
                print(statusCode)
                completion(LoginService.LoginError.serverError)
            }
            
        }
    }
}

extension RegisterHttpRemotService {
    enum Constants {
        static let registerUrl = "http://localhost:8601/register/"
    }
}
