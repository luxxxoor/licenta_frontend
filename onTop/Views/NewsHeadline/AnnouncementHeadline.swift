//
//  AnnouncementHeadline.swift
//  onTop
//
//  Created by Alexandru Vrincean on 10/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class AnnouncementHeadline: IBView {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var organisationButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var stackView: UIStackView!
    
    override var backgroundColor: UIColor? {
        didSet {
            headerView?.backgroundColor = backgroundColor
            rootView?.backgroundColor = backgroundColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        headerView.roundCorners([.topLeft, .topRight], radius: Constants.viewRadius)
        rootView?.roundCorners([.topLeft, .topRight], radius: Constants.viewRadius)
        roundCorners([.topLeft, .topRight], radius: Constants.viewRadius)
    }
}

private extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = frame
        rectShape.position = center
        rectShape.path = UIBezierPath(roundedRect: bounds,
                                      byRoundingCorners: corners,
                                      cornerRadii: CGSize(width: radius, height: radius)).cgPath
        layer.mask = rectShape
    }
}

private extension AnnouncementHeadline {
    enum Constants {
        static let viewRadius: CGFloat = 20.0
    }
}

