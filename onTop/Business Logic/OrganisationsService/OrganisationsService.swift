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
    
    func getOrganisationName(top number: Int, containing text: String, completion: @escaping OrganisationsRemoteService.GetOrganisationsByNameCompletion) {
        remote.getOrganisationName(top: number, containing: text, completion: completion)
    }
    
    func getOrganisation(by name: String, completion: @escaping OrganisationsRemoteService.GetOrganisationByNameCompletion) {
        remote.getOrganisation(by: name, completion: completion)
    }
    
    func getMostPopularOrganisations(top number: Int, completion: @escaping OrganisationsRemoteService.GetOrganisationsByNameCompletion) {
        remote.getMostPopularOrganisations(top: number, completion: completion)
    }
}
