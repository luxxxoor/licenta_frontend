//
//  AnnouncementsTabCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 10/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

import UIKit

class AnnouncementsTabCoordinator: Coordinator {
    private let presenter: UITabBarController
    private let serviceProvider: ServiceProvider
    private let navigationVC: UINavigationController
    private let announcementsTabVC: AnnouncementsTabVC
    private var announcementCoordinator: AnnouncementCoordinator?
    
    init(presenter: UITabBarController, serviceProvider: ServiceProvider){
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.announcementsTabVC = AnnouncementsTabVC.instantiate()
        self.navigationVC = UINavigationController()
        
        let icon = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "news_feed-icon"), selectedImage: nil)
        self.announcementsTabVC.tabBarItem = icon
    }
    
    func start() {
        setupVM(for: announcementsTabVC)
        
        navigationVC.isNavigationBarHidden = true
        navigationVC.navigationBar.isTranslucent = false
        
        if var vcs = presenter.viewControllers {
            vcs.append(navigationVC)
            presenter.setViewControllers(vcs, animated: false)
        } else {
            presenter.setViewControllers([navigationVC], animated: false)
        }
        
        navigationVC.pushViewController(announcementsTabVC, animated: true)
    }
    
    private func setupVM(for announcementsTabVC: AnnouncementsTabVC) {
        serviceProvider.announcementsService.getAnnouncements{
            result in
            
            switch result {
            case .failure(let error):
                announcementsTabVC.showError(error)
            case .success(let announcements):
                announcementsTabVC.announcementsTabVM = AnnouncementsTabVM(announcements: announcements)
                announcementsTabVC.announcementsTabVM?.delegate = self
            }
        }
    }
}

extension AnnouncementsTabCoordinator: AnnouncementsTabVMDelegate {
    func announcementsTabVM(_ announcementsTabVM: AnnouncementsTabVM, didSelect announcement: Announcement) {
        announcementCoordinator = AnnouncementCoordinator(presenter: navigationVC, serviceProvider: serviceProvider, announcement: announcement)
        announcementCoordinator?.start()
    }
    
    func announcementsTabVM(_ announcementsTabVM: AnnouncementsTabVM, didSelect organistion: String) {
        
    }
    
    
}
