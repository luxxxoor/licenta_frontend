//
//  SubscriptionRemoteServiceReal.swift
//  onTop
//
//  Created by Alexandru Vrincean on 03/07/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class SubscriptionRemoteServiceReal: SubscriptionRemoteService {
    func toggleSubscription(to organisation: Organisation, completion: @escaping SubscribeCompletion) {
        guard let accessToken = UserDefaults.standard.string(forKey: "Authorization"),
            let userId = UserDefaults.standard.string(forKey: "userId")
            else { return }
        
        let headers = [
            "Authorization" : accessToken,
            "userId" : userId
        ]
        
        let parameters = [ "organisationId" : organisation.id ]
        
        Alamofire.request(Constants.subscribeUrl, method: organisation.isUserSubscriber ? .delete : .put, parameters: parameters, encoding: URLEncoding.queryString, headers: headers)
            .responseJSON {
                response in
                
                if response.response?.statusCode == 200 {
                    DispatchQueue.main.async { completion(nil) }
                } else {
                    if let result = response.result.value {
                        if let errors = JSON(result)["errors"].array {
                            let exception = errors[0].stringValue
                            
                            if exception == Constants.alreadyExistingSubscriptionException {
                                let error = SubscriptionService.SubscriptionError.alreadyExistingSubscription
                                DispatchQueue.main.async { completion(error) }
                            } else if exception == Constants.subscriptionNotFoundException {
                                let error = SubscriptionService.SubscriptionError.subscriptionNotFound
                                DispatchQueue.main.async { completion(error) }
                            }
                        } else {
                            completion(SubscriptionService.SubscriptionError.serverError)
                        }
                    }
                }
        }
    }
    
    func getSubscribedOrganisations(completion: @escaping GetSubscribedOrganisationsCompletion) {
        guard let accessToken = UserDefaults.standard.string(forKey: "Authorization"),
            let userId = UserDefaults.standard.string(forKey: "userId")
            else { return }
        
        let headers = [
            "Authorization" : accessToken,
            "userId" : userId
        ]
        
        Alamofire.request(Constants.subscribedOrganisationsUrl, method: .post, parameters: nil, encoding: URLEncoding.queryString, headers: headers)
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
                    
                    DispatchQueue.main.async { completion(.success(organisations)) }
                }
        }
    }
}

private extension SubscriptionRemoteServiceReal {
    enum Constants {
        static let subscribeUrl = "\(SubscriptionRemoteServiceConstants.address)/organisation/subscription/v1"
        static let subscribedOrganisationsUrl = "\(SubscriptionRemoteServiceConstants.address)/organisation/subscription/v1/getUserSubscriptions"
        static let alreadyExistingSubscriptionException = "com.licenta.ogm.Exceptions.AlreadyExistingSubscriptionException"
        static let subscriptionNotFoundException = "com.licenta.ogm.Exceptions.SubscriptionNotFoundException"
    }
}
