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
    private let chatOrganisationTabCoordinator: ChatOrganisationTabCoordinator
    private let settingsTabCoordinator: SettingsTabCoordinator
    private let tabBarVC: TabBarVC
    
    init(presenter: UINavigationController, serviceProvider: ServiceProvider){
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.tabBarVC = TabBarVC.instantiate()
        self.announcementsTabCoordinator = AnnouncementsTabCoordinator(presenter: tabBarVC, serviceProvider: serviceProvider)
        self.searchOrganisationTabCoordinator = SearchOrganisationTabCoordinator(presenter: tabBarVC, serviceProvider: serviceProvider)
        self.chatOrganisationTabCoordinator = ChatOrganisationTabCoordinator(presenter: tabBarVC, serviceProvider: serviceProvider)
        self.settingsTabCoordinator = SettingsTabCoordinator(presenter: tabBarVC, serviceProvider: serviceProvider)
    }
    
    func start() {
        announcementsTabCoordinator.start()
        searchOrganisationTabCoordinator.start()
        chatOrganisationTabCoordinator.start()
        settingsTabCoordinator.start()
        presenter.pushViewController(tabBarVC, animated: true)
        #warning("not working, ask mihai")
        tabBarVC.selectedIndex = 0
    }
}
