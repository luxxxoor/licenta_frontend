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
    private let announcementsTabCoordinator1: AnnouncementsTabCoordinator
    private let announcementsTabCoordinator2: AnnouncementsTabCoordinator
    private let announcementsTabCoordinator3: AnnouncementsTabCoordinator
    private let announcementsTabCoordinator4: AnnouncementsTabCoordinator
    private let tabBarVC: TabBarVC
    
    init(presenter: UINavigationController, serviceProvider: ServiceProvider){
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.tabBarVC = TabBarVC.instantiate()
        self.announcementsTabCoordinator1 = AnnouncementsTabCoordinator(presenter: tabBarVC, serviceProvider: serviceProvider)
        self.announcementsTabCoordinator2 = AnnouncementsTabCoordinator(presenter: tabBarVC, serviceProvider: serviceProvider)
        self.announcementsTabCoordinator3 = AnnouncementsTabCoordinator(presenter: tabBarVC, serviceProvider: serviceProvider)
        self.announcementsTabCoordinator4 = AnnouncementsTabCoordinator(presenter: tabBarVC, serviceProvider: serviceProvider)
    }
    
    func start() {
        announcementsTabCoordinator1.start()
        announcementsTabCoordinator2.start()
        announcementsTabCoordinator3.start()
        announcementsTabCoordinator4.start()
        presenter.pushViewController(tabBarVC, animated: true)
    }
}
