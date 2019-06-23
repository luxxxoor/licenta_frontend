//
//  CommentsService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 23/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

class CommentsService {
    private let remote: CommentsRemoteService
    
    init(remote: CommentsRemoteService) {
        self.remote = remote
    }
    
    func getComments(for announcementId: Int, completion: @escaping CommentsRemoteService.GetCommentsCompletion) {
        remote.getComments(for: announcementId, completion: completion)
    }
}
