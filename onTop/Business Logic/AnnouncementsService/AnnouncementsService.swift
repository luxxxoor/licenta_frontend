//
//  AnnouncementsService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 10/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

class AnnouncementsService {
    private let remote: AnnouncementsRemoteService
    
    init(remote: AnnouncementsRemoteService) {
        self.remote = remote
    }
    
    func getAnnouncements(completion: @escaping AnnouncementsRemoteService.GetAnnouncementsCompletion) {
        remote.getAnnouncements(completion: completion)
    }
    
    func getAnnouncements(for organisation: Organisation, completion: @escaping AnnouncementsRemoteService.GetAnnouncementsForOrganisationCompletion) {
        remote.getAnnouncements(for: organisation, completion: completion)
    }
}
