//
//  PhoneRemoteServiceMock.swift
//  onTop
//
//  Created by Alexandru Vrincean on 01.02.2021.
//  Copyright © 2021 Alexandru Vrincean. All rights reserved.
//

import Foundation

struct PhoneRemoteServiceMock: PhoneRemoteService {
    func verifyPhoneNumber(_ phoneNumber: String, completion: @escaping VerifyPhoneCompletion) {
        completion(.success("verificationID"))
    }

    func signIn(verificationCode: String, verificationID: String, completion: @escaping SignInCompletion) {
        completion(.success("token"))
    }
}
