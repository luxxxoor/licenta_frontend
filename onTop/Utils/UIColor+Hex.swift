//
//  UIColor+Hex.swift
//  onTop
//
//  Created by Alexandru Vrincean on 07/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

import UIKit

extension UIColor {
    convenience init(hex: UInt, alpha: CGFloat = 1) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let b = CGFloat((hex & 0x0000FF) >> 0) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}
