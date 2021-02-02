//
//  AnnouncementHeadline.swift
//  onTop
//
//  Created by Alexandru Vrincean on 10/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

protocol AnnouncementHeadlineDelegate: AnyObject {
    func announcementHeadlineDidTapReadMore(_ announcementHeadline: AnnouncementHeadline)
    func announcementHeadlineDidTapOnOrganisation(_ announcementHeadline: AnnouncementHeadline, organisationName: String)
}

class AnnouncementHeadline: IBView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var organisationButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: ImageViewForReusableCells?
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var readMoreButton: UIButton!
    weak var delegate: AnnouncementHeadlineDelegate?
    
    override var backgroundColor: UIColor? {
        didSet {
            headerView?.backgroundColor = backgroundColor
            rootView?.backgroundColor = backgroundColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        imageView?.clipsToBounds = true
        imageView?.contentMode = .scaleAspectFit
        
        readMoreButton.setImage(#imageLiteral(resourceName: "right_arrow-icon"), for: .normal)
        readMoreButton.imageView?.contentMode = .scaleAspectFit
        readMoreButton.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        readMoreButton.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        readMoreButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: -1.0)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        headerView.roundCorners([.topLeft, .topRight], radius: Constants.viewRadius)
        rootView?.roundCorners([.topLeft, .topRight], radius: Constants.viewRadius)
        roundCorners([.topLeft, .topRight], radius: Constants.viewRadius)
    }
    
    @IBAction private func didTapReadMore(_ sender: UIButton) {
        delegate?.announcementHeadlineDidTapReadMore(self)
    }
    
    @IBAction private func didTapOnOrganisation(_ sender: UIButton) {
        guard let organisation = sender.title(for: .normal) else { return }
        delegate?.announcementHeadlineDidTapOnOrganisation(self, organisationName: organisation)
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

