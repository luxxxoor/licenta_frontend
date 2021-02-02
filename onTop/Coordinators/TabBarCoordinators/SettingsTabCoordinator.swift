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
    private let navigationVC: UINavigationController
    private let settingsUnsubscribeCoordinator: SettingsUnsubscribeCoordinator
    private let changeEmailCoordinator: ChangeEmailCoordinator
    private let changePasswordCoordinator: ChangePasswordCoordinator
    
    init(presenter: UITabBarController, serviceProvider: ServiceProvider){
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.settingsTabVC = SettingTabVC.instantiate()
        self.navigationVC = UINavigationController()
        self.settingsUnsubscribeCoordinator = SettingsUnsubscribeCoordinator(presenter: navigationVC, serviceProvider: serviceProvider)
        self.changeEmailCoordinator = ChangeEmailCoordinator(presenter: navigationVC)
        self.changePasswordCoordinator = ChangePasswordCoordinator(presenter: navigationVC)
        
        self.settingsTabVC.delegate = self
        let icon = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "settings"), selectedImage: nil)
        self.settingsTabVC.tabBarItem = icon
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
        
        navigationVC.pushViewController(settingsTabVC, animated: true)
    }
}


extension SettingsTabCoordinator: SettingTabVCDelegate {
    func settingTabVCDidTapOnCheckSubscriptions(_ settingTabVC: SettingTabVC) {
        settingsUnsubscribeCoordinator.start()
    }
    func settingTabVCDidTapOnChangeEmail(_ settingTabVC: SettingTabVC) {
        changeEmailCoordinator.start()
    }
    func settingTabVCDidTapOnChangePassword(_ settingTabVC: SettingTabVC) {
        changePasswordCoordinator.start()
    }
    func settingTabVCDidTapOnLogout(_ settingTabVC: SettingTabVC) {
        if let vc = presenter.navigationController?.children.first(where: { $0 is PhoneVerificationViewController}) {
            presenter.navigationController?.popToViewController(vc, animated: true)
        }
    }
}
