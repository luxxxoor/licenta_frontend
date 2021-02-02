//
//  Organisation.swift
//  onTop
//
//  Created by Alexandru Vrincean on 23/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Organisation {
    let id: Int
    let name: String
    let isUserSubscriber: Bool
}

extension Organisation {
    init?(json: JSON) {
        self.id = json[BackendKeys.id].intValue
        self.name = json[BackendKeys.name].stringValue
        self.isUserSubscriber = json[BackendKeys.isUserSubscriber].boolValue
    }
}

private extension Organisation {
    enum BackendKeys {
        static let id = "id"
        static let name = "name"
        static let isUserSubscriber = "isUserSubscriber"
    }
}
