//
//  SettingsTabCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 22/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class SettingsTabCoordinator: Coordinator {
    private let presenter: UITabBarController
    private let serviceProvider: ServiceProvider
    private let settingsTabVC: SettingTabVC
    
    init(presenter: UITabBarController, serviceProvider: ServiceProvider){
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.settingsTabVC = SettingTabVC.instantiate()
        
        let icon = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "settings"), selectedImage: nil)
        self.settingsTabVC.tabBarItem = icon
    }
    
    func start() {
        if var vcs = presenter.viewControllers {
            vcs.append(settingsTabVC)
            presenter.setViewControllers(vcs, animated: false)
        } else {
            presenter.setViewControllers([settingsTabVC], animated: false)
        }
    }
}
