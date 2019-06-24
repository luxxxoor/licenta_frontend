//
//  ChatOrganisationTabCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 22/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class ChatOrganisationTabCoordinator: Coordinator {
    private let presenter: UITabBarController
    private let serviceProvider: ServiceProvider
    private let chatOrganisationTabVC: ChatOrganisationTabVC
    private let navigationVC: UINavigationController
    private let conversationCoordinator: ConversationCoordinator
    
    init(presenter: UITabBarController, serviceProvider: ServiceProvider){
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.chatOrganisationTabVC = ChatOrganisationTabVC.instantiate()
        self.navigationVC = UINavigationController()
        self.conversationCoordinator = ConversationCoordinator(presenter: navigationVC, serviceProvider: serviceProvider)
        
        let icon = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "chat-icon"), selectedImage: nil)
        self.chatOrganisationTabVC.tabBarItem = icon
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
        
        navigationVC.pushViewController(chatOrganisationTabVC, animated: true)
        conversationCoordinator.start()
    }
}
