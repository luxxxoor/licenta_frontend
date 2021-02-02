//
//  SubscriptionService+SubscriptionError.swift
//  onTop
//
//  Created by Alexandru Vrincean on 03/07/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

extension SubscriptionService {
    enum SubscriptionError: LocalizedError {
        case alreadyExistingSubscription
        case subscriptionNotFound
        case serverError
        
        var errorDescription: String? {
            switch self {
            case .serverError:
                return "A apărul o eroare la server. Operația a fost anulată."
            case .alreadyExistingSubscription:
                return "Ești deja abonat la această organizație."
            case .subscriptionNotFound:
                return "Abonamentul nu există."
            }
        }
    }
}
