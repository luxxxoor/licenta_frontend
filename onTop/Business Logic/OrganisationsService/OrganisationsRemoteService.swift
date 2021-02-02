//
//  OrganisationsRemoteService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 22/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

protocol OrganisationsRemoteService {
    typealias GetOrganisationsByNameCompletion = (Result<[Organisation], Error>) -> Void
    typealias GetOrganisationByNameCompletion = (Result<Organisation, Error>) -> Void
    
    func getOrganisationName(top number: Int, containing text: String, completion: @escaping GetOrganisationsByNameCompletion)
    func getOrganisation(by name: String, completion: @escaping GetOrganisationByNameCompletion)
    func getMostPopularOrganisations(top number: Int, completion: @escaping GetOrganisationsByNameCompletion)
}

struct OrganisationsRemoteServiceConstants {
    static let address = "http://localhost:8606"
}
