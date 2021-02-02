//
//  CommentsRemoteServiceMock.swift
//  onTop
//
//  Created by Alexandru Vrincean on 23/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

class CommentsRemoteServiceMock: CommentsRemoteService {
    static private var contor = 0
    
    var comm1: [Comment] = []
    var comm2: [Comment] = []
    
    func submitComment(_ comment: String, for announcementId: Int, completion: @escaping SubmitCommentCompletion) {
        if CommentsRemoteServiceMock.contor % 3 == 0 {
            comm1.append(Comment(id: 0, userName: "licenta.user", description: comment))
        } else {
            comm2.append(Comment(id: 0, userName: "licenta.user", description: comment))
        }
    }
    
    func getComments(for announcementId: Int, completion: @escaping GetCommentsCompletion) {
        CommentsRemoteServiceMock.contor += 1
        
        if CommentsRemoteServiceMock.contor % 3 == 0 {
            completion(Result.success([Comment(id: 0, userName: "Andrei", description: "În sfârșit !"),
                                       Comment(id: 1, userName: "Ana", description: "Nu sunt sigură ca am înțeles anunțul.."),
                                       Comment(id: 2, userName: "Ion", description: "Super tare !")]))
        } else if CommentsRemoteServiceMock.contor % 3 == 1 {
            completion(Result.success([Comment(id: 0, userName: "Andreas", description: "Teribilă decizie..."),
                                       Comment(id: 1, userName: "Aniela", description: "Ce păcat... chiar era mai bine înainte.")]))
        }
    }
}
