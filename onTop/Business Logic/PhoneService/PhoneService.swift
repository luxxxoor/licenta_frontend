//
//  PhoneService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 01.02.2021.
//  Copyright © 2021 Alexandru Vrincean. All rights reserved.
//

import Foundation

final class PhoneService {
    private let remote: PhoneRemoteService
    private var verificationId: String? = nil

    init(remote: PhoneRemoteService) {
        self.remote = remote
    }

    func verifyPhoneNumber(_ phoneNumber: String, completion: ((Bool) -> Void)? = nil) {
        remote.verifyPhoneNumber(phoneNumber) { result in
            switch result {
            case .failure(let error): fatalError(error.localizedDescription)
            case .success(let verificationId):
                self.verificationId = verificationId
            }

            let success = (try? result.get()) != nil
            completion?(success)
        }
    }

    func signIn( verificationCode: String, completion: @escaping PhoneRemoteService.SignInCompletion) {
        guard let verificationId = verificationId else { fatalError("Invalid VerificationId") }

        remote.signIn(verificationCode: verificationCode, verificationID: verificationId, completion: completion)
    }
}
