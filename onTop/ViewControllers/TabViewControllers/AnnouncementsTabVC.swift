//
//  AnnouncementsTabVC.swift
//  onTop
//
//  Created by Alexandru Vrincean on 10/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class AnnouncementsTabVC: UIViewController, StoryboardViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var announcementsTabVM: AnnouncementsTabVM? {
        didSet {
            if isViewLoaded {
                collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.decelerationRate = .fast
    }
}

extension AnnouncementsTabVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return announcementsTabVM?.announcements.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.itemCellIdentifier, for: indexPath)
        
        if let cell = cell as? AnnouncementHeadlineCollectionViewCell {
            announcementsTabVM?.configureCell(cell, at: indexPath)
        }
        
        return cell
    }
}

extension AnnouncementsTabVC {
    enum Constants {
        static let itemCellIdentifier = "announcementsCell"
        static let tableViewCellHeight: CGFloat = 300.0
    }
}
