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
    weak var initiateDelegate: InitiateConversationCoordinatorDelegate?
    
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
    func searchOrganisationTabVCDidAppear(_ searchOrganisationTabVC: SearchOrganisationTabVC) {
        guard let organisationVM = self.searchOrganisationTabVC.organisationVM,
              let organisation = serviceProvider.subscriptionService.organisations.first(where: { $0.id == organisationVM.organisation.id })  else { return }

        self.searchOrganisationTabVC.organisationVM = OrganisationVM(organisation: organisation)
    }

    func searchOrganisationTabVCDidToggleSubscribe(_ searchOrganisationTabVC: SearchOrganisationTabVC) {
        guard let organisationVM = self.searchOrganisationTabVC.organisationVM else { return }
        serviceProvider.subscriptionService.toggleSubscription(to: organisationVM.organisation) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .failure(let error):
                self.searchOrganisationTabVC.showError(error)
            case .success(_):
                let organisation = Organisation(id: organisationVM.organisation.id,
                                                name: organisationVM.organisation.name,
                                                isUserSubscriber: !organisationVM.organisation.isUserSubscriber)
                self.searchOrganisationTabVC.organisationVM = OrganisationVM(organisation: organisation)
            }
        }
    }
    
    func searchOrganisationTabVC(_ searchOrganisationTabVC: SearchOrganisationTabVC, didSearchFor text: String) {
        serviceProvider.organisationsService.getOrganisationName(top: 5, containing: text) {
            [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let organisations):
                let org = self.serviceProvider.subscriptionService.organisations
                let goodOrg = org.filter { organisations.map { $0.id }.contains($0.id) }
                self.searchOrganisationTabVC.organisationsVM = OrganisationsVM(organisations: goodOrg)
            case .failure(let error):
                self.searchOrganisationTabVC.showError(error)
            }
        }
    }
    
    func searchOrganisationTabVC(_ searchOrganisationTabVC: SearchOrganisationTabVC, didSelect organisation: Organisation) {
        self.searchOrganisationTabVC.organisationsVM = nil
        serviceProvider.announcementsService.getAnnouncements(for: organisation) {
            [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let announcements):
                self.searchOrganisationTabVC.organisationVM = OrganisationVM(organisation: organisation)
                self.searchOrganisationTabVC.announcementsTabVM = AnnouncementsTabVM(announcements: announcements)
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
        announcementCoordinator?.initiateDelegate = initiateDelegate
        announcementCoordinator?.start()
    }
    
    func announcementsTabVM(_ announcementsTabVM: AnnouncementsTabVM, didSelect organistionName: String) {
        
    }
}

extension SearchOrganisationTabCoordinator: AnnouncementsTabCoordinatorDelegate {
    func announcementsTabCoordinator(_ announcementsTabCoordinator: AnnouncementsTabCoordinator, didSelect organisation: Organisation) {
        searchOrganisationTabVC.tabBarController?.selectedIndex = 1
        searchOrganisationTabVC.setSearchedString(organisation.name)
        searchOrganisationTabVC.organisationsVM = nil
        serviceProvider.announcementsService.getAnnouncements(for: organisation) {
            [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let announcements):
                self.searchOrganisationTabVC.organisationVM = OrganisationVM(organisation: organisation)
                self.searchOrganisationTabVC.announcementsTabVM = AnnouncementsTabVM(announcements: announcements)
                self.searchOrganisationTabVC.announcementsTabVM?.delegate = self
            case .failure(let error):
                self.searchOrganisationTabVC.showError(error)
            }
        }
    }

}
