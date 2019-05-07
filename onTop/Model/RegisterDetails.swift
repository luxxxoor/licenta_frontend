//
//  RegisterDetails.swift
//  onTop
//
//  Created by Alexandru Vrincean on 15/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

struct RegisterDetails: Encodable {
    var nickName: String = ""
    var password: String = ""
    var repassword: String = ""
    var email: String = ""
}
