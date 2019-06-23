//
//  OrganisationRemoteServiceMock.swift
//  onTop
//
//  Created by Alexandru Vrincean on 22/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

class OrganisationsRemoteServiceMock: OrganisationsRemoteService {
    
    private let organisations: [String] = ["Google", "Ziar de Cluj", "Stiri", "Nemaivazut", "waka waka waka waka waka waka waka"]
    
    func getOrganisationName(containing text: String, completion: @escaping getOrganisationsByNameCompletion) {
        
        let matchedOrganisations = organisations.filter { $0.lowercased().contains(text.lowercased()) }
        completion(Result.success(matchedOrganisations))
    }
}
