//
//  Result.swift
//  onTop
//
//  Created by Alexandru Vrincean on 07/05/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(_ value: T)
    case failure(_ error: Error)
}
