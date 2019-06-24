//
//  AnnouncementVM.swift
//  onTop
//
//  Created by Alexandru Vrincean on 23/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class AnnouncementVM {
    private let announcement: Announcement
    
    init(announcement: Announcement) {
        self.announcement = announcement
    }
    
    func setTitleLabel(_ label: UILabel) {
        label.text = announcement.title
    }
    
    func setImageView(_ imageView: UIImageView) {
        if let imageUrl = announcement.imageUrl {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        imageView.image = UIImage(data: imageData)
                    }
                }
            }
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
