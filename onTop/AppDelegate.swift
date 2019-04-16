//
//  AppDelegate.swift
//  onTop
//
//  Created by Alexandru Vrincean on 07/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        #if DEBUG
        self.appCoordinator = AppCoordinator(window: window, serviceProvider: ServiceMockFactory())
        #else
        self.appCoordinator = AppCoordinator(window: window, serviceProvider: ServiceFactory())
        #endif
        self.window = window
        
        appCoordinator?.start()
        
        return true
    }


}

