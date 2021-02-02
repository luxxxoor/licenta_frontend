//
//  RoPhoneNumberTextField.swift
//  onTop
//
//  Created by Alexandru Vrincean on 01.02.2021.
//  Copyright © 2021 Alexandru Vrincean. All rights reserved.
//

import PhoneNumberKit

final class RoPhoneNumberTextField: PhoneNumberTextField {
    override var defaultRegion: String {
        get {
            return "RO"
        }
        set {} // exists for backward compatibility
    }
}

