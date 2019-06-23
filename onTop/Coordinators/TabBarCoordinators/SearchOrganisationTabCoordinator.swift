//
//  SearchOrganisationTabCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 22/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class SearchOrganisationTabCoordinator: Coordinator {
    private let presenter: UITabBarController
    private let serviceProvider: ServiceProvider
    private let searchOrganisationTabVC: SearchOrganisationTabVC
    private let navigationVC: UINavigationController
    private var announcementCoordinator: AnnouncementCoordinator?
    
    init(presenter: UITabBarController, serviceProvider: ServiceProvider){
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.searchOrganisationTabVC = SearchOrganisationTabVC.instantiate()
        self.navigationVC = UINavigationController()
        self.searchOrganisationTabVC.delegate = self
        
        let icon = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "search-icon"), selectedImage: nil)
        self.searchOrganisationTabVC.tabBarItem = icon
    }
    
    func start() {
        navigationVC.isNavigationBarHidden = true
        navigationVC.navigationBar.isTranslucent = false
        
        if var vcs = presenter.viewControllers {
            vcs.append(navigationVC)
            presenter.setViewControllers(vcs, animated: false)
        } else {
            presenter.setViewControllers([navigationVC], animated: false)
        }
        
        navigationVC.pushViewController(searchOrganisationTabVC, animated: true)
    }
}

extension SearchOrganisationTabCoordinator: SearchOrganisationTabVCDelegate {
    func searchOrganisationTabVCDidToggleSubscribe(_ searchOrganisationTabVC: SearchOrganisationTabVC) {
        
        guard let announcementsTabVM = self.searchOrganisationTabVC.announcementsTabVM else { return }
        
        self.searchOrganisationTabVC.announcementsTabVM = AnnouncementsTabVM(announcements: announcementsTabVM.announcements, organisation: announcementsTabVM.organisation, isSubscriber: !announcementsTabVM.isSubscriber!)
        self.searchOrganisationTabVC.announcementsTabVM?.delegate = self
    }
    
    func searchOrganisationTabVC(_ searchOrganisationTabVC: SearchOrganisationTabVC, didSearchFor text: String) {
        serviceProvider.organisationsService.getOrganisationName(containing: text) {
            [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let organisations):
                self.searchOrganisationTabVC.organisationsTabVM = OrganisationsTabVM(organisations: organisations)
            case .failure(let error):
                self.searchOrganisationTabVC.showError(error)
            }

        }
    }
    
    func searchOrganisationTabVC(_ searchOrganisationTabVC: SearchOrganisationTabVC, didSelectOrganisation organisation: String) {
        self.searchOrganisationTabVC.organisationsTabVM = nil
        serviceProvider.announcementsService.getAnnouncements(for: organisation) {
            [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let announcements, let isSubscribed):
                let organisation = announcements.first!.organisationName
                self.searchOrganisationTabVC.announcementsTabVM = AnnouncementsTabVM(announcements: announcements, organisation: organisation, isSubscriber: isSubscribed)
                self.searchOrganisationTabVC.announcementsTabVM?.delegate = self
            case .failure(let error):
                self.searchOrganisationTabVC.showError(error)
            }
        }
    }
}

extension SearchOrganisationTabCoordinator: AnnouncementsTabVMDelegate {
    func announcementsTabVM(_ announcementsTabVM: AnnouncementsTabVM, didSelect announcement: Announcement) {
        announcementCoordinator = AnnouncementCoordinator(presenter: navigationVC, serviceProvider: serviceProvider, announcement: announcement)
        announcementCoordinator?.start()
    }
    
    func announcementsTabVM(_ announcementsTabVM: AnnouncementsTabVM, didSelect organistion: String) {
        
    }
    
    
}
