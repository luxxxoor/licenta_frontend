//
//  AnnouncementsRemoteServiceReal.swift
//  onTop
//
//  Created by Alexandru Vrincean on 10/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AnnouncementsRemoteServiceReal: AnnouncementsRemoteService {
    func getAnnouncements(for organisation: Organisation, completion: @escaping GetAnnouncementsForOrganisationCompletion) {
        guard let accessToken = UserDefaults.standard.string(forKey: "Authorization"),
            let userId = UserDefaults.standard.string(forKey: "userId")
            else { return }
        
        let headers = [
            "Authorization" : accessToken,
            "userId" : userId
        ]
        
        let parameters = ["organisationId": "\(organisation.id)"]
        
        Alamofire.request(Constants.getAssesmentsByOrganisationIdUrl, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers)
            .responseJSON {
                response in
                
                if let result = response.result.value {
                    
                    let jsonArray = JSON(result).arrayValue
                    var announcements: [Announcement] = []
                    for json in jsonArray {
                        if let announcement = Announcement(json: json) {
                            announcements.append(announcement)
                        }
                    }
                    
                    DispatchQueue.main.async { completion(.success(announcements)) }
                }
        }
    }
    
    func getAnnouncements(completion: @escaping GetAnnouncementsCompletion) {
        guard let accessToken = UserDefaults.standard.string(forKey: "Authorization"),
                let userId = UserDefaults.standard.string(forKey: "userId")
        else { return }
        
        let headers = [
            "Authorization" : accessToken,
            "userId" : userId
        ]
        
        Alamofire.request(Constants.getAssesmentsByUserIdUrl, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: headers)
            .responseJSON {
                response in
                
                if let result = response.result.value {
                    
                    let jsonArray = JSON(result).arrayValue
                    var announcements: [Announcement] = []
                    for json in jsonArray {
                        if let announcement = Announcement(json: json) {
                            announcements.append(announcement)
                        }
                    }
                    
                    DispatchQueue.main.async { completion(.success(announcements)) }
                }
        }
    }
}

private extension AnnouncementsRemoteServiceReal {
    enum Constants {
        static let getAssesmentsByUserIdUrl = "\(AnnouncementsRemoteServiceConstants.address)/organisation/announcement/v1/getByUserId"
        static let getAssesmentsByOrganisationIdUrl = "\(AnnouncementsRemoteServiceConstants.address)/organisation/announcement/v1/getByOrganisationId"
    }
}
