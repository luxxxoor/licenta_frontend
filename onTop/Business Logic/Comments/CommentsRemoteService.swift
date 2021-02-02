//
//  CommentsRemoteService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 23/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

protocol CommentsRemoteService {
    typealias SubmitCommentCompletion = (Error?) -> Void
    typealias GetCommentsCompletion = (Result<[Comment], Error>) -> Void
    
    func submitComment(_ comment: String, for announcementId: Int,  completion: @escaping SubmitCommentCompletion)
    func getComments(for announcementId: Int, completion: @escaping GetCommentsCompletion)
}

struct CommentsRemoteServiceConstants {
    static let address = "http://localhost:8606"
}
