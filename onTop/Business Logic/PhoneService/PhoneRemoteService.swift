//
//  PhoneRemoteService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 01.02.2021.
//  Copyright © 2021 Alexandru Vrincean. All rights reserved.
//

import Foundation

protocol PhoneRemoteService {
    typealias VerifyPhoneCompletion = (Result<String, Error>) -> Void
    typealias SignInCompletion = (Result<String, Error>) -> Void

    func verifyPhoneNumber(_ phoneNumber: String, completion: @escaping VerifyPhoneCompletion)
    func signIn(verificationCode: String, verificationID: String, completion: @escaping SignInCompletion)
}
