//
//  AnnouncementsRemoteService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 10/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

protocol AnnouncementsRemoteService {
    typealias GetAnnouncementsCompletion = (Result<[Announcement]>) -> Void
    typealias GetAnnouncementsForOrganisationCompletion = (Result<([Announcement])>) -> Void
    
    func getAnnouncements(completion: @escaping GetAnnouncementsCompletion)
    func getAnnouncements(for organisation: String,completion: @escaping GetAnnouncementsForOrganisationCompletion)
}

struct AnnouncementsRemoteServiceConstants {
    static let address = "http://localhost:8604"
}
