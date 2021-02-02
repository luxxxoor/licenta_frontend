//
//  Comment.swift
//  onTop
//
//  Created by Alexandru Vrincean on 23/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Comment {
    let id: Int
    let userName: String
    let description: String
}

extension Comment {
    init?(json: JSON) {
        self.id = json[BackendKeys.id].intValue
        self.userName = json[BackendKeys.userName].stringValue
        self.description = json[BackendKeys.description].stringValue
    }
}

private extension Comment {
    enum BackendKeys {
        static let id = "id"
        static let userName = "userName"
        static let description = "text"
    }
}
