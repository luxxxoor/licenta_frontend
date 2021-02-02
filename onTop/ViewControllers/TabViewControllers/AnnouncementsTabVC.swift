//
//  AnnouncementsTabVC.swift
//  onTop
//
//  Created by Alexandru Vrincean on 10/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

protocol AnnouncementsTabVCDelegate: AnyObject {
    func announcementsTabVCDidRefresh(_ announcementsTabVC: AnnouncementsTabVC)
}

class AnnouncementsTabVC: UIViewController, StoryboardViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private var refresher: UIRefreshControl!
    
    weak var delegate: AnnouncementsTabVCDelegate?
    
    var announcementsTabVM: AnnouncementsTabVM? {
        didSet {
            if isViewLoaded {
                refresher?.endRefreshing()
                collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.decelerationRate = .fast
        
        refresher = UIRefreshControl()
        collectionView!.alwaysBounceVertical = true
        refresher.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        collectionView!.addSubview(refresher)
    }
    
    @objc private func reloadData() {
        delegate?.announcementsTabVCDidRefresh(self)
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
    }
}
