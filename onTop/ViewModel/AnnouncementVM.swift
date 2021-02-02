//
//  AnnouncementVM.swift
//  onTop
//
//  Created by Alexandru Vrincean on 23/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class AnnouncementVM {
    private(set) var announcement: Announcement
    private(set) var canStartConversation: Bool?
    
    init(announcement: Announcement, canStartConversation: Bool? = nil) {
        self.announcement = announcement
        self.canStartConversation = canStartConversation
    }
    
    func setTitleLabel(_ label: UILabel) {
        label.text = announcement.title
    }
    
    func setImageView(_ imageView: ImageViewForReusableCells) {
        if let imageUrl = announcement.imageUrl {
            imageView.loadImageUsingUrl(imageUrl)
        } else {
            imageView.removeFromSuperview()
        }
    }
    
    func setDescriptionLabel(_ label: UILabel, superView: UIView? = nil) {
        if let description = announcement.description {
            label.text = description
        } else if let superView = superView {
            superView.removeFromSuperview()
        } else {
            label.removeFromSuperview()
        }
        
    }
    
    func setDateLabel(_ label: UILabel) {
        label.text = announcement.date
    }
    
    func setOrganisationNameLabel(_ label: UILabel) {
        label.text = announcement.organisationName
    }
}
