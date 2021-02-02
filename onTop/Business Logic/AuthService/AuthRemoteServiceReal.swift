//
//  AuthRemoteServiceReal.swift
//  onTop
//
//  Created by Alexandru Vrincean on 01.02.2021.
//  Copyright © 2021 Alexandru Vrincean. All rights reserved.
//

import Alamofire
import SwiftyJSON

struct AuthRemoteServiceReal: AuthRemoteService {
    func register(firebaseToken: String, userInfo: UserInfo, completion: @escaping RegisterCompletion) {
        let headers = ["Firebase-Token" : firebaseToken]
        let parameters = [
            "name": userInfo.name,
            "email": userInfo.email
        ]

        Alamofire.request(
            Constants.registerURL,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        ).validate(statusCode: [200])
        .response() { response in
            if let error = response.error {
                switch response.response?.statusCode {
                case 401: completion(AuthServiceError.invalidToken)
                case 409: completion(AuthServiceError.alreadyCreated)
                default: completion(AuthServiceError.other(error: error))
                }
            } else {
                completion(nil)
            }
        }
    }

    func login(firebaseToken: String, completion: @escaping LoginCompletion) {
        /// here we shall use the default session without interceptor
        Alamofire.request(
            Constants.loginURL,
            method: .post,
            parameters: ["Firebase-Token": firebaseToken],
            encoding: URLEncoding.default,
            headers: Constants.defaultJsonHeaders
        ).validate(statusCode: [200])
        .responseJSON() { response in
            if let result = response.result.value {

                let json = JSON(result)
                if let authToken = json["Authorization"].string,
                   let refreshToken = json["Refresh_Token"].string {
                    completion(nil)
                } else {
                    completion(AuthServiceError.invalidToken)
                }
                
            }
        }
    }
}

// MARK: - Constants

private enum Constants {
    static let registerURL = "http://localhost:8605/api/"
    static let loginURL = "http://192.168.1.194:8605/api/tokens"

    static let defaultJsonHeaders = ["Content-Type" : "application/json"]
}



