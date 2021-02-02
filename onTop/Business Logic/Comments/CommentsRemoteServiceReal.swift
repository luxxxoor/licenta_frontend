//
//  CommentsRemoteServiceReal.swift
//  onTop
//
//  Created by Alexandru Vrincean on 04/07/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class CommentsRemoteServiceReal: CommentsRemoteService {
    
    func submitComment(_ comment: String, for announcementId: Int, completion: @escaping SubmitCommentCompletion) {
        guard let accessToken = UserDefaults.standard.string(forKey: "Authorization"),
              let userId = UserDefaults.standard.string(forKey: "userId")
        else { return }
        
        let parameters = ["announcementId" : "\(announcementId)",
                          "text" : comment]
        let headers = [
            "Authorization" : accessToken,
            "userId" : userId
        ]
        
        Alamofire.request(Constants.submitComment, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON {
            response in
            
            guard let statusCode = response.response?.statusCode else { return }
            
            if statusCode == 200 {
                DispatchQueue.main.async { completion(nil) }
            } else if statusCode == 404 {
                let error = CommentsService.CommentError.announcementNotFound
                DispatchQueue.main.async { completion(error) }
            } else {
                let error = CommentsService.CommentError.serverError
                DispatchQueue.main.async { completion(error) }
            }
        }
    }
    
    func getComments(for announcementId: Int, completion: @escaping GetCommentsCompletion) {
        guard let accessToken = UserDefaults.standard.string(forKey: "Authorization"),
              let userId = UserDefaults.standard.string(forKey: "userId")
        else { return }
        
        let headers = [
            "Authorization" : accessToken,
            "userId" : userId
        ]
        
        let parameters = ["announcementId": "\(announcementId)"]
        
        Alamofire.request(Constants.getComments, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers)
            .responseJSON { response in
                
                if let result = response.result.value {
                    let jsonArray = JSON(result).arrayValue
                    var comments: [Comment] = []
                    for json in jsonArray {
                        if let comment = Comment(json: json) {
                            comments.append(comment)
                        }
                    }

                    DispatchQueue.main.async {
                        completion(.success(comments))
                    }
                }
            }
    }
}



private extension CommentsRemoteServiceReal {
    enum Constants {
        static let submitComment = "\(CommentsRemoteServiceConstants.address)/organisation/comment/v1/submitComment"
        static let getComments = "\(CommentsRemoteServiceConstants.address)/organisation/comment/v1/getComments"
    }
}
