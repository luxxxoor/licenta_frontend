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
    
    func getOrganisationName(top number: Int, containing text: String, completion: @escaping GetOrganisationsByNameCompletion) {
        
        let matchedOrganisations = organisations.filter { $0.name.lowercased().contains(text.lowercased()) }
        completion(Result.success(Array(matchedOrganisations.prefix(number))))
    }
    
    func getOrganisation(by name: String, completion: @escaping GetOrganisationByNameCompletion) {
        if let matchedOrganisation = organisations.first(where: { $0.name == name }) {
            completion(Result.success(matchedOrganisation))
        }
    }
    
    func getMostPopularOrganisations(top number: Int, completion: @escaping GetOrganisationsByNameCompletion) {
        
        completion(Result.success(Array(organisations.prefix(number))))
    }
}
