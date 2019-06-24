//
//  SubscribeTableViewCell.swift
//  onTop
//
//  Created by Alexandru Vrincean on 24/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class SubscribeTableViewCell: UITableViewCell {
    @IBOutlet weak var organisationName: UILabel!
    @IBOutlet weak var subscribeButton: UIButton!
    
    override var tag: Int {
        didSet {
            subscribeButton.tag = tag
        }
    }
}
