//
//  Announcement.swift
//  onTop
//
//  Created by Alexandru Vrincean on 10/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Announcement {
    let id: Int
    let organisationName: String
    let title: String
    let imageUrl: URL?
    let description: String?
    let date: String
}

extension Announcement {
    init?(json: JSON) {
        self.id = json[BackendKeys.id].intValue
        self.organisationName = json[BackendKeys.organisationName].stringValue
        self.title = json[BackendKeys.title].stringValue
        if let imageUrlString = json[BackendKeys.imageUrl].string {
            self.imageUrl = URL(string: imageUrlString)
        } else {
            self.imageUrl = nil
        }
        self.description = json[BackendKeys.description].string
        self.date = json[BackendKeys.date].stringValue
    }
}

private extension Announcement {
    enum BackendKeys {
        static let id = "id"
        static let organisationName = "organisationName"
        static let title = "title"
        static let imageUrl = "imageUrl"
        static let description = "description"
        static let date = "date"
    }
}
