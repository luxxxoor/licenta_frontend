//
//  SubscriptionRemoteService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 03/07/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

protocol SubscriptionRemoteService {
    typealias SubscribeCompletion = (Error?) -> Void
    typealias UnsubscribeCompletion = (Error?) -> Void
    typealias GetSubscribedOrganisationsCompletion = (Result<[Organisation], Error>) -> Void
    
    func toggleSubscription(to organisation: Organisation, completion: @escaping SubscribeCompletion)
    func getSubscribedOrganisations(completion: @escaping GetSubscribedOrganisationsCompletion)
}

struct SubscriptionRemoteServiceConstants {
    static let address = "http://localhost:8606"
}
