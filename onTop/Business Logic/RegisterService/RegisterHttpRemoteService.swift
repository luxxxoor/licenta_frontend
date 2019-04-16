//
//  RegisterHttpRemoteService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 15/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

class RegisterHttpRemotService: RegisterRemoteService {
    func register(details: RegisterDetails, completion: @escaping RegisterHttpRemotService.RegisterCompletion) {
        let url = String(format: Constants.registerUrl)
        guard let serviceUrl = URL(string: url) else { return }
        let parameterDictionary = ["nickName" : details.nickName, "password" : details.password, "email" : details.email]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                DispatchQueue.main.async { completion(error) }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else { fatalError() }
            
            if httpResponse.statusCode == 200 {
                DispatchQueue.main.async { completion(nil) }
            } else if httpResponse.statusCode == 403 {
                let error = RegisterService.RegisterError.forbidden
                DispatchQueue.main.async { completion(error) }
            } else {
                let error = RegisterService.RegisterError.serverError
                DispatchQueue.main.async { completion(error) }
            }
            }.resume()
    }
}

extension RegisterHttpRemotService {
    enum Constants {
        static let registerUrl = "http://localhost:8601/registration/v1/register/"
    }
}
