//
//  OrganisationsTabVM.swift
//  onTop
//
//  Created by Alexandru Vrincean on 22/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class OrganisationsVM {
    let organisations: [Organisation]
    
    init(organisations: [Organisation]) {
        self.organisations = organisations
    }
    
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let organisation = organisations[indexPath.row]
        cell.textLabel?.text = organisation.name
        cell.textLabel?.textColor = Constants.textColor
    }
    
    func configureSubscribeCell(_ cell: SubscribeTableViewCell, at indexPath: IndexPath) {
        let organisation = organisations[indexPath.row]
        cell.organisationName.text = organisation.name
        let subscribeButtonTitle: String
        
        if organisation.isUserSubscriber {
            subscribeButtonTitle = "  Dezabonează-te  "
        } else {
            subscribeButtonTitle = "  Abonează-te  "
        }
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Constants.font,
            .foregroundColor: Constants.titleColor
        ]
        
        let buttonAttributedTitle = NSMutableAttributedString(string: subscribeButtonTitle, attributes: attributes)
        
        cell.subscribeButton.backgroundColor = Constants.backgroundColor
        cell.subscribeButton.layer.cornerRadius = Constants.cornerRadius
        cell.subscribeButton.setAttributedTitle(buttonAttributedTitle, for: .normal)
        
        cell.organisationName.textColor = Constants.textColor
        
        cell.tag = indexPath.row
    }
}

private extension OrganisationsVM {
    enum Constants {
        static let font = UIFont.systemFont(ofSize: 14)
        static let titleColor = UIColor.white
        static let backgroundColor = UIColor.CustomColors.systemBlue
        static let textColor = UIColor.CustomColors.systemBlue
        static let cornerRadius:CGFloat = 15
    }
}

