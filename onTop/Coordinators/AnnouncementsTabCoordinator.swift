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
    private let announcementsTabVC: AnnouncementsTabVC
    
    init(presenter: UITabBarController, serviceProvider: ServiceProvider){
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.announcementsTabVC = AnnouncementsTabVC.instantiate()
        
        let icon = UITabBarItem(title: "News", image: nil, selectedImage: nil)
        self.announcementsTabVC.tabBarItem = icon
        
        setupVM(for: announcementsTabVC)
    }
    
    func start() {
        if var vcs = presenter.viewControllers {
            vcs.append(announcementsTabVC)
            presenter.setViewControllers(vcs, animated: false)
        } else {
            presenter.setViewControllers([announcementsTabVC], animated: false)
        }
    }
    
    private func setupVM(for announcementsTabVC: AnnouncementsTabVC) {
        serviceProvider.announcementsService.getAnnouncements{
            result in
            
            switch result {
            case .failure(let error):
                announcementsTabVC.showError(error)
            case .success(let announcements):
                announcementsTabVC.announcementsTabVM = AnnouncementsTabVM(announcements: announcements)
            }
        }
    }
}
