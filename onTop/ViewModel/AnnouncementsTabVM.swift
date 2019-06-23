//
//  AnnouncementsTabVM.swift
//  onTop
//
//  Created by Alexandru Vrincean on 10/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

protocol AnnouncementsTabVMDelegate: AnyObject {
    func announcementsTabVM(_ announcementsTabVM: AnnouncementsTabVM, didSelect announcement: Announcement)
    func announcementsTabVM(_ announcementsTabVM: AnnouncementsTabVM, didSelect organistion: String)
}

class AnnouncementsTabVM {
    let organisation: String?
    let isSubscriber: Bool?
    let announcements: [Announcement]
    weak var delegate: AnnouncementsTabVMDelegate?
    
    init(announcements: [Announcement], organisation: String? = nil, isSubscriber: Bool? = nil) {
        self.announcements = announcements
        self.organisation = organisation
        self.isSubscriber = isSubscriber
    }
    
    func configureSubscribeButton(_ button: UIButton) {
        guard let isSubscriber = isSubscriber, let organisation = organisation else { return }
        
        button.isHidden = false
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Constants.boldFont,
            .foregroundColor: UIColor.white
        ]
        
        let subscribeText = isSubscriber ? "Dezabonează-te de la" : "Abonează-te la"
        let buttonTitle = "\(subscribeText) \(organisation)"
        
        let buttonAttributedTitle = NSMutableAttributedString(string: buttonTitle, attributes: attributes)
        
        button.setAttributedTitle(buttonAttributedTitle, for: .normal)
    }
    
    func configureCell(_ cell: AnnouncementHeadlineCollectionViewCell, at indexPath: IndexPath) {
        let announcement = announcements[indexPath.row]
        cell.announcementOrganisationName = announcement.organisationName
        cell.announcementTitle = announcement.title
        cell.announcementDescription = announcement.description
        cell.announcementDate = announcement.date
        cell.tag = indexPath.row
        cell.announcementDelegate = self
        
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

extension AnnouncementsTabVM: AnnouncementHeadlineDelegate {
    func announcementHeadlineDidTapReadMore(_ announcementHeadline: AnnouncementHeadline) {
        let announcement = announcements[announcementHeadline.tag]
        delegate?.announcementsTabVM(self, didSelect: announcement)
    }
    
    func announcementHeadlineDidTapOnOrganisation(_ announcementHeadline: AnnouncementHeadline, organisationName: String) {
        let organisation = announcements[announcementHeadline.tag].organisationName
        delegate?.announcementsTabVM(self, didSelect: organisation)
    }
}

private extension AnnouncementsTabVM {
    enum Constants {
        static let boldFont = UIFont.boldSystemFont(ofSize: 17)
        static let titleColor = UIColor.CustomColors.lightGray
    }
}

