//
//  PhoneRemoteServiceReal.swift
//  onTop
//
//  Created by Alexandru Vrincean on 01.02.2021.
//  Copyright © 2021 Alexandru Vrincean. All rights reserved.
//

import FirebaseAuth

struct PhoneRemoteServiceReal: PhoneRemoteService {
    func verifyPhoneNumber(_ phoneNumber: String, completion: @escaping VerifyPhoneCompletion) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                completion(.failure(PhoneRemoteServiceRealError.verifyPhoneNumerError(reason: error.localizedDescription)))
                return
            }

            guard let verificationID = verificationID else {
                completion(.failure(PhoneRemoteServiceRealError.invalidVerificationId))
                return
            }

            completion(.success(verificationID))
        }
    }

    func signIn(verificationCode: String, verificationID: String, completion: @escaping SignInCompletion) {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                completion(.failure(PhoneRemoteServiceRealError.signInError(reason: error.localizedDescription)))
                return
            }

            authResult?.user.getIDToken() { token, error in
                if let error = error {
                    completion(.failure(PhoneRemoteServiceRealError.authError(reason: error.localizedDescription)))
                    return
                }

                guard let token = token else {
                    completion(.failure(PhoneRemoteServiceRealError.invalidToken))
                    return
                }

                completion(.success(token))
            }
        }
    }
}

// MARK: - Error

private enum PhoneRemoteServiceRealError: LocalizedError {
    case invalidVerificationId, invalidToken, verifyPhoneNumerError(reason: String), authError(reason: String), signInError(reason: String)

    var errorDescription: String? {
        switch self {
        case .invalidVerificationId:
            return "Invalid verificationId received."
        case .invalidToken:
            return "Invalid token received."
        case .verifyPhoneNumerError(let reason):
            return "Phone number verification failed.\n Reason: \(reason)"
        case .authError(let reason):
            return "Authentication failed.\n Reason: \(reason)"
        case .signInError(let reason):
            return "Sign in failed.\n Reason: \(reason)"
        }
    }
}

// MARK: - Constants

private enum Constants {
    static let registerURL = "http://localhost:8605/api/users"
    static let loginURL = "http://localhost:8605/login"
}


