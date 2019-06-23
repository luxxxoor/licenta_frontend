//
//  OrganisationsRemoteService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 22/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

protocol OrganisationsRemoteService {
    typealias getOrganisationsByNameCompletion = (Result<[String]>) -> Void
    
    func getOrganisationName(containing text: String, completion: @escaping getOrganisationsByNameCompletion)
}

struct OrganisationsRemoteServiceConstants {
    static let address = "http://localhost:8604"
}
