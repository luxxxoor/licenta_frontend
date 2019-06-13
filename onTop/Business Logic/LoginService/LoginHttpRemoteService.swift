//
//  LoginHttpRemoteService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 08/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation
import Alamofire

class LoginHttpRemotService: LoginRemoteService {
    func login(details: LoginDetails, completion: @escaping LoginRemoteService.LoginCompletion) {
        let url = String(format: Constants.loginUrl)
        guard let serviceUrl = URL(string: url) else { return }
        let parameterDictionary = ["username" : details.userName, "password" : details.password]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async { completion(error) }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else { fatalError() }
            
            if httpResponse.statusCode == 200 {
                DispatchQueue.main.async { completion(nil) }
            } else if httpResponse.statusCode == 401 {
                let error = LoginService.LoginError.unauthorized
                DispatchQueue.main.async { completion(error) }
            } else {
                let error = LoginService.LoginError.serverError
                DispatchQueue.main.async { completion(error) }
            }
        }.resume()
    }
}

extension LoginHttpRemotService {
    enum Constants {
        static let loginUrl = "\(LoginRemoteServiceConstants.address)/auth/"
    }
}
