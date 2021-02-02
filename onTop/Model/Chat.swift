//
//  Chat.swift
//  onTop
//
//  Created by Alexandru Vrincean on 04/07/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

struct Chat {
    let announcementId: Int
    let organisationName: String
    let announcementTitle: String
}

extension Chat: Hashable {}
