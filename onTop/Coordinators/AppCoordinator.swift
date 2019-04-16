//
//  AppCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 07/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let rootVC: UINavigationController
    private let loginCoordinator: Coordinator
    
    init(window: UIWindow, serviceProvider: ServiceProvider) {
        self.window = window
        self.rootVC = UINavigationController()
        self.loginCoordinator = LoginCoordinator(presenter: rootVC, serviceProvider: serviceProvider)
        rootVC.isNavigationBarHidden = true
        rootVC.navigationBar.isTranslucent = false
    }
    
    func start() {
        window.rootViewController = rootVC
        loginCoordinator.start()
        window.makeKeyAndVisible()
    }
}
