//
//  AnnouncementsTabCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 10/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation
import UIKit

protocol AnnouncementsTabCoordinatorDelegate: AnyObject {
    func announcementsTabCoordinator(_ announcementsTabCoordinator: AnnouncementsTabCoordinator, didSelect organisation: Organisation)
}

class AnnouncementsTabCoordinator: Coordinator {
    private let presenter: UITabBarController
    private let serviceProvider: ServiceProvider
    private let navigationVC: UINavigationController
    private let announcementsTabVC: AnnouncementsTabVC
    private var announcementCoordinator: AnnouncementCoordinator?
    weak var delegate: AnnouncementsTabCoordinatorDelegate?
    weak var initiateDelegate: InitiateConversationCoordinatorDelegate?
    
    init(presenter: UITabBarController, serviceProvider: ServiceProvider){
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.announcementsTabVC = AnnouncementsTabVC.instantiate()
        self.navigationVC = UINavigationController()
        
        let icon = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "news_feed-icon"), selectedImage: nil)
        self.announcementsTabVC.tabBarItem = icon
        self.announcementsTabVC.delegate = self
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
        serviceProvider.announcementsService.getAnnouncements { result in
            switch result {
            case .failure(let error):
                announcementsTabVC.showError(error)
            case .success(let announcements):
                let org = self.serviceProvider.subscriptionService.organisations.filter { $0.isUserSubscriber }
                let goodAnnouncements = announcements.filter { a in org.map { $0.name }.contains(a.organisationName) }

                announcementsTabVC.announcementsTabVM = AnnouncementsTabVM(announcements: goodAnnouncements)
                announcementsTabVC.announcementsTabVM?.delegate = self
            }
        }
    }
}

extension AnnouncementsTabCoordinator: AnnouncementsTabVCDelegate {
    func announcementsTabVCDidRefresh(_ announcementsTabVC: AnnouncementsTabVC) {
        serviceProvider.announcementsService.getAnnouncements { result in
            
            switch result {
            case .failure(let error):
                announcementsTabVC.showError(error)
            case .success(let announcements):
                let org = self.serviceProvider.subscriptionService.organisations.filter { $0.isUserSubscriber }
                let goodAnnouncements = announcements.filter { a in org.map { $0.name }.contains(a.organisationName) }

                announcementsTabVC.announcementsTabVM = AnnouncementsTabVM(announcements: goodAnnouncements)
                announcementsTabVC.announcementsTabVM?.delegate = self
            }
        }
    }
}

extension AnnouncementsTabCoordinator: AnnouncementsTabVMDelegate {
    func announcementsTabVM(_ announcementsTabVM: AnnouncementsTabVM, didSelect announcement: Announcement) {
        announcementCoordinator = AnnouncementCoordinator(presenter: navigationVC, serviceProvider: serviceProvider, announcement: announcement)
        announcementCoordinator?.initiateDelegate = initiateDelegate
        announcementCoordinator?.start()
    }
    
    func announcementsTabVM(_ announcementsTabVM: AnnouncementsTabVM, didSelect organistionName: String) {
        serviceProvider.organisationsService.getOrganisation(by: organistionName) {
            [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let organisation):
                self.delegate?.announcementsTabCoordinator(self, didSelect: organisation)
            case .failure(let error):
                self.announcementsTabVC.showError(error)
            }
        }
    }
}
