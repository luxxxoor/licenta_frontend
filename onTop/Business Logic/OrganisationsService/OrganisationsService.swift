//
//  OrganisationsService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 22/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

class OrganisationsService {
    private let remote: OrganisationsRemoteService
    
    init(remote: OrganisationsRemoteService) {
        self.remote = remote
    }
    
    func getOrganisationName(containing text: String, completion: @escaping OrganisationsRemoteService.GetOrganisationsByNameCompletion) {
        remote.getOrganisationName(containing: text, completion: completion)
    }
}
