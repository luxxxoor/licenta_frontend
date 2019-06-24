//
//  OrganisationRemoteServiceMock.swift
//  onTop
//
//  Created by Alexandru Vrincean on 22/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

class OrganisationsRemoteServiceMock: OrganisationsRemoteService {
    
    private let organisations: [Organisation] = [Organisation(id: 0, name: "Google", isUserSubscriber: true),
                                                 Organisation(id: 1, name: "Ziar de Cluj", isUserSubscriber: true),
                                                 Organisation(id: 2, name: "Stiri", isUserSubscriber: false),
                                                 Organisation(id: 3, name: "Nemaivazut", isUserSubscriber: false),
                                                 Organisation(id: 4, name: "waka waka waka waka waka waka waka", isUserSubscriber: false)]
    
    func getOrganisationName(containing text: String, completion: @escaping GetOrganisationsByNameCompletion) {
        
        let matchedOrganisations = organisations.filter { $0.name.lowercased().contains(text.lowercased()) }
        completion(Result.success(matchedOrganisations))
    }
}
