//
//  AnnouncementHeadlineTableViewCell.swift
//  onTop
//
//  Created by Alexandru Vrincean on 10/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class AnnouncementHeadlineTableViewCell: UITableViewCell {
    @IBOutlet private weak var announcementHeadlineView: AnnouncementHeadline!
    
    var announcementTitle: String? {
        get {
            return announcementHeadlineView.titleLabel.text
        }
        set {
            announcementHeadlineView.titleLabel.text = newValue
        }
    }
    
    var announcementDescription: String? {
        get {
            return announcementHeadlineView.descriptionLabel.text
        }
        set {
            announcementHeadlineView.descriptionLabel.text = newValue
        }
    }
    
    var announcementImage: UIImage? {
        get {
            return announcementHeadlineView.imageView.image
        }
        set {
            announcementHeadlineView.imageView.image = newValue
        }
    }
    
    var announcementOrganisationName: String {
        get {
            guard let organisationName = announcementHeadlineView.organisationButton.title(for: .normal) else { fatalError() }
            return organisationName
        }
        set {
            announcementHeadlineView.organisationButton.setTitle(newValue, for: .normal)
        }
    }
    
    var announcementDate: String {
        get {
            guard let date = announcementHeadlineView.dateLabel.text else { fatalError() }
            return date
        }
        set {
            announcementHeadlineView.dateLabel.text = newValue
        }
    }
    
    func removeImageView() {
        guard let imageView = announcementHeadlineView.imageView else { return }
        imageView.removeFromSuperview()
    }
}
