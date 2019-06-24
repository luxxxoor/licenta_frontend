//
//  OrganisationVM.swift
//  onTop
//
//  Created by Alexandru Vrincean on 24/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class OrganisationVM {
    let organisation: Organisation
    
    init(organisation: Organisation) {
        self.organisation = organisation
    }
    
    func configureSubscribeButton(_ button: UIButton) {
        button.isHidden = false
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Constants.boldFont,
            .foregroundColor: Constants.titleColor
        ]
        
        let subscribeText = organisation.isUserSubscriber ? "Dezabonează-te de la" : "Abonează-te la"
        let buttonTitle = "\(subscribeText) \(organisation.name)"
        
        let buttonAttributedTitle = NSMutableAttributedString(string: buttonTitle, attributes: attributes)
        
        button.setAttributedTitle(buttonAttributedTitle, for: .normal)
    }
}

private extension OrganisationVM {
    enum Constants {
        static let boldFont = UIFont.boldSystemFont(ofSize: 17)
        static let titleColor = UIColor.white
    }
}

