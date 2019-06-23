//
//  OrganisationsTabVM.swift
//  onTop
//
//  Created by Alexandru Vrincean on 22/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class OrganisationsTabVM {
    let organisations: [String]
    
    init(organisations: [String]) {
        self.organisations = organisations
    }
    
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let organisation = organisations[indexPath.row]
        cell.textLabel?.text = organisation
    }
}
