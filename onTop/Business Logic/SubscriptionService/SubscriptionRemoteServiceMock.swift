//
//  SubscriptionRemoteServiceMock.swift
//  onTop
//
//  Created by Alexandru Vrincean on 03/07/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

class SubscriptionRemoteServiceMock: SubscriptionRemoteService {
    func toggleSubscription(to organisation: Organisation, completion: @escaping SubscribeCompletion) {
        completion(nil)
    }
    
    func getSubscribedOrganisations(completion: @escaping GetSubscribedOrganisationsCompletion) {
        completion(Result.success([]))
    }
}
