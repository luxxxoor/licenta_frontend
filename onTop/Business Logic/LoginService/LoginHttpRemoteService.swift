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
        let parameterDictionary = ["nickname" : details.nickName, "password" : details.password]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Content-Type", forHTTPHeaderField: "application/json")
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
            
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
            }
            
            DispatchQueue.main.async {
                //completion(exists ? nil : LoginService.LoginError.invalidNumber)
            }
        }.resume()
        
        
        /*let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(Constants.loginUrl, method: .post, parameters: details, encoder: URLEncoding.httpBody, headers: headers).responseJSON {
            response in
            
            guard let statusCode = response.response?.statusCode else { print("escaping without status code #1"); return }
            
            if statusCode == 200 {
                completion(nil)
            } else if statusCode == 401 {
                completion(LoginService.LoginError.unauthorized)
            } else {
                print(statusCode)
                completion(LoginService.LoginError.serverError)
            }
            
        }*/
    }
}

extension LoginHttpRemotService {
    enum Constants {
        static let loginUrl = "\(LoginRemoteServiceConstants.address)/auth/"
    }
}
