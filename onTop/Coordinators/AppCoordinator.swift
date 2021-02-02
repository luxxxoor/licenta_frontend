//
//  AppCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 07/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit
import Alamofire

class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let rootVC: UINavigationController
    private let serviceProvider: ServiceProvider
    private let interceptor = RequestInterceptor()
    private var phoneVerificationCoordinator: PhoneVerificationCoordinator?
    private var mainAppCoordinator: MainAppCoordinator?

    init(window: UIWindow, serviceProvider: ServiceProvider) {
        self.window = window
        self.rootVC = UINavigationController()
        self.serviceProvider = serviceProvider

        rootVC.isNavigationBarHidden = true
        rootVC.navigationBar.isTranslucent = false
        Alamofire.SessionManager.default.adapter = interceptor
        Alamofire.SessionManager.default.retrier = interceptor
    }

    func start() {
        window.rootViewController = rootVC
        window.makeKeyAndVisible()

        phoneVerificationCoordinator = PhoneVerificationCoordinator(presenter: rootVC, delegate: self)
        phoneVerificationCoordinator?.start()
    }
}

// MARK: PhoneVerificationCoordinatorDelegate

extension AppCoordinator: PhoneVerificationCoordinatorDelegate {
    func phoneVerificationCoordinatorDidComplete() {
        mainAppCoordinator = MainAppCoordinator(presenter: rootVC, serviceProvider: serviceProvider)
        mainAppCoordinator?.start()
    }
}

// MARK: MainAppCoordinatorDelegate

#warning("implement it")
//extension AppCoordinator: MainAppCoordinatorDelegate {
//    func mainAppCoordinatorDidLogOut(_ mainAppCoordinator: MainAppCoordinator) {
//        phoneVerificationCoordinator = PhoneVerificationCoordinator(presenter: rootVC, delegate: self)
//        phoneVerificationCoordinator?.start()
//
//        self.mainAppCoordinator = nil
//    }
//}
//
