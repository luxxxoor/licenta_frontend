//
//  AnnouncementsTabVC.swift
//  onTop
//
//  Created by Alexandru Vrincean on 10/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class AnnouncementsTabVC: UIViewController, StoryboardViewController {
    
    @IBOutlet private  weak var tableView: UITableView!
    var announcementsTabVM: AnnouncementsTabVM? {
        didSet {
            if isViewLoaded {
                tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension AnnouncementsTabVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcementsTabVM?.announcements.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.itemCellIdentifier, for: indexPath)
        
        if let cell = cell as? AnnouncementHeadlineTableViewCell {
            announcementsTabVM?.configureCell(cell, at: indexPath)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableViewCellHeight;
    }
}

extension AnnouncementsTabVC {
    enum Constants {
        static let itemCellIdentifier = "announcementsCell"
        static let tableViewCellHeight: CGFloat = 300.0
    }
}
