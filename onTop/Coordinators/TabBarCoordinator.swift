//
//  TabBarCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 09/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit


class TabBarCoordinator: Coordinator {
    private let presenter: UINavigationController
    private let serviceProvider: ServiceProvider
    private let announcementsTabCoordinator: AnnouncementsTabCoordinator
    private let searchOrganisationTabCoordinator: SearchOrganisationTabCoordinator
    private let chatTabTableCoordinator: ChatTabTableCoordinator
    private let settingsTabCoordinator: SettingsTabCoordinator
    private let tabBarVC: TabBarVC
    
    init(presenter: UINavigationController, serviceProvider: ServiceProvider){
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.tabBarVC = TabBarVC.instantiate()
        self.announcementsTabCoordinator = AnnouncementsTabCoordinator(presenter: tabBarVC, serviceProvider: serviceProvider)
        self.searchOrganisationTabCoordinator = SearchOrganisationTabCoordinator(presenter: tabBarVC, serviceProvider: serviceProvider)
        self.chatTabTableCoordinator = ChatTabTableCoordinator(presenter: tabBarVC, serviceProvider: serviceProvider)
        self.settingsTabCoordinator = SettingsTabCoordinator(presenter: tabBarVC, serviceProvider: serviceProvider)
        
        self.announcementsTabCoordinator.delegate = searchOrganisationTabCoordinator
        self.announcementsTabCoordinator.initiateDelegate = chatTabTableCoordinator
        self.searchOrganisationTabCoordinator.initiateDelegate = chatTabTableCoordinator
    }
    
    func start() {
        announcementsTabCoordinator.start()
        searchOrganisationTabCoordinator.start()
        chatTabTableCoordinator.start()
        settingsTabCoordinator.start()
        tabBarVC.selectedIndex = 1
        presenter.pushViewController(tabBarVC, animated: true)
        tabBarVC.selectedIndex = 0
    }
}
