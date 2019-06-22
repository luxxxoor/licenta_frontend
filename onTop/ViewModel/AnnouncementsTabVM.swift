//
//  AnnouncementsTabVM.swift
//  onTop
//
//  Created by Alexandru Vrincean on 10/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class AnnouncementsTabVM {
    private(set) var announcements: [Announcement]
    
    init(announcements: [Announcement]) {
        self.announcements = announcements
    }
    
    func configureCell(_ cell: AnnouncementHeadlineCollectionViewCell, at indexPath: IndexPath) {
        let announcement = announcements[indexPath.row]
        cell.announcementOrganisationName = announcement.organisationName
        cell.announcementTitle = announcement.title
        cell.announcementDescription = announcement.description
        cell.announcementDate = announcement.date
        
        if indexPath.row % 2 == 0 {
            cell.viewBackgroundColor = UIColor.CustomColors.lightGray
        } else {
            cell.viewBackgroundColor = .lightGray
        }
        
        if let imageUrl = announcement.imageUrl {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        cell.announcementImage = UIImage(data: imageData)
                    }
                }
            }
        } else {
            cell.removeImageView()
        }
    }
}
