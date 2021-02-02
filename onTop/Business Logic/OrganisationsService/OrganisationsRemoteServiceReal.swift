//
//  OrganisationsRemoteServiceReal.swift
//  onTop
//
//  Created by Alexandru Vrincean on 02/07/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class OrganisationsRemoteServiceReal: OrganisationsRemoteService {
    func getOrganisationName(top number: Int, containing text: String, completion: @escaping GetOrganisationsByNameCompletion) {
        
        guard let accessToken = UserDefaults.standard.string(forKey: "Authorization"),
            let userId = UserDefaults.standard.string(forKey: "userId")
            else { return }
        
        let headers = [
            "Authorization" : accessToken,
            "userId" : userId
        ]
        
        Alamofire.request(Constants.getMostPopularOrganisationsUrl, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: headers)
            .responseJSON {
                response in
                
                if let result = response.result.value {
                    
                    let jsonArray = JSON(result).arrayValue
                    var organisations: [Organisation] = []
                    for json in jsonArray {
                        if let organisation = Organisation(json: json) {
                            organisations.append(organisation)
                        }
                    }
                    
                    let matchedOrganisations = organisations.filter { $0.name.lowercased().contains(text.lowercased()) }
                    DispatchQueue.main.async { completion(.success(Array(matchedOrganisations.prefix(number)))) }
                }
        }
    }
    
    func getOrganisation(by name: String, completion: @escaping GetOrganisationByNameCompletion) {
        guard let accessToken = UserDefaults.standard.string(forKey: "Authorization"),
            let userId = UserDefaults.standard.string(forKey: "userId")
            else { return }
        
        let headers = [
            "Authorization" : accessToken,
            "userId" : userId
        ]
        
        Alamofire.request(Constants.getMostPopularOrganisationsUrl, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: headers)
            .responseJSON {
                response in
                
                if let result = response.result.value {
                    
                    let jsonArray = JSON(result).arrayValue
                    var organisations: [Organisation] = []
                    for json in jsonArray {
                        if let organisation = Organisation(json: json) {
                            organisations.append(organisation)
                        }
                    }
                    
                    if let matchedOrganisation = organisations.first(where: { $0.name == name }) {
                        DispatchQueue.main.async { completion(.success(matchedOrganisation)) }
                    }
                }
        }
    }
    
    func getMostPopularOrganisations(top number: Int, completion: @escaping GetOrganisationsByNameCompletion) {
        
        guard let accessToken = UserDefaults.standard.string(forKey: "Authorization"),
            let userId = UserDefaults.standard.string(forKey: "userId")
            else { return }
        
        let headers = [
            "Authorization" : accessToken,
            "userId" : userId
        ]
        
        Alamofire.request(Constants.getMostPopularOrganisationsUrl, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: headers)
            .responseJSON {
                response in
                
                if let result = response.result.value {
                    
                    let jsonArray = JSON(result).arrayValue
                    var organisations: [Organisation] = []
                    for json in jsonArray {
                        if let organisation = Organisation(json: json) {
                            organisations.append(organisation)
                        }
                    }
                    
                    DispatchQueue.main.async { completion(.success(Array(organisations.prefix(number)))) }
                }
        }
    }
}

private extension OrganisationsRemoteServiceReal {
    enum Constants {
        static let getMostPopularOrganisationsUrl = "\(AnnouncementsRemoteServiceConstants.address)/organisation/organisations/v1/getAllSortedByPopularity"
        static let getOrganisationsByNameUrl = "\(AnnouncementsRemoteServiceConstants.address)/organisation/organisations/v1/getByUserId"
    }
}

