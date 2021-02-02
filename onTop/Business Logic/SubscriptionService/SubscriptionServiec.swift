//
//  SubscriptionServiec.swift
//  onTop
//
//  Created by Alexandru Vrincean on 03/07/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation


class SubscriptionService {
    private let remote: SubscriptionRemoteService
    private(set) var organisations: [Organisation] = []
    
    init(remote: SubscriptionRemoteService) {
        self.remote = remote
    }

    func setOrganisations(organisations: [Organisation]) {
        self.organisations = organisations
    }
    
    func toggleSubscription(to organisation: Organisation, completion: @escaping ((Result<[Organisation], Error>) -> Void)) {
        remote.toggleSubscription(to: organisation) { error in
            self.organisations[organisation.id] = Organisation(
                id: organisation.id,
                name: organisation.name,
                isUserSubscriber: !organisation.isUserSubscriber
            )
            completion(.success(self.organisations))
        }
    }
    
    func getSubscribedOrganisations(completion: @escaping SubscriptionRemoteService.GetSubscribedOrganisationsCompletion) {
        remote.getSubscribedOrganisations { _ in
            completion(.success(self.organisations))
        }
    }
}
