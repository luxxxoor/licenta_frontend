//
//  IBView.swift
//  onTop
//
//  Created by Alexandru Vrincean on 10/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

@IBDesignable
class IBView: UIView, NibView {
    // MARK: - NibRepresentable
    
    var parentView: UIView {
        return self
    }
    
    // MARK: - properties
    
    override var intrinsicContentSize: CGSize {
        return frame.size
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}
