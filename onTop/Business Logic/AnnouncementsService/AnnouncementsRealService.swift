//
//  AnnouncementsRealService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 10/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

class AnnouncementsRealService: AnnouncementsRemoteService {
    
    func getAnnouncements(completion: @escaping GetAnnouncementsCompletion) {
        let url = Constants.getAssesmentsUrl
        
        guard let urlEncoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let serviceUrl = URL(string: urlEncoded)
            else { return }
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else { fatalError() }
            
            if httpResponse.statusCode == 200 {
                guard
                    let data = data,
                    let jsonArray = (try? JSONSerialization.jsonObject(with: data, options: [])) as? NSArray
                    else { return }
                
                var announcements: [Announcement] = []
                
                for json in jsonArray {
                    if let json = json as? NSDictionary {
                        let imageUrl: URL?
                        if let imageUrlString = json["imageUrl"] as? String {
                            imageUrl = URL(string: imageUrlString)
                        } else {
                            imageUrl = nil
                        }
                        announcements.append(Announcement(
                            organisationName: json["organisationName"] as! String,
                            title: json["title"] as! String,
                            imageUrl: imageUrl,
                            description: json["description"] as? String,
                            date: json["date"] as! String))
                    }
                }
                
                DispatchQueue.main.async { completion(.success(announcements)) }
            }
        }.resume()
    }
}

private extension AnnouncementsRealService {
    enum Constants {
        #warning("for testing")
        static let getAssesmentsUrl = "\(AnnouncementsRemoteServiceConstants.address)/organisation/announcement/v1/getByUserId?userId=1"
    }
}
