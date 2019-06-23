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
    
    init(presenter: UITabBarController, serviceProvider: ServiceProvider){
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.chatOrganisationTabVC = ChatOrganisationTabVC.instantiate()
        
        let icon = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "chat-icon"), selectedImage: nil)
        self.chatOrganisationTabVC.tabBarItem = icon
    }
    
    func start() {
        if var vcs = presenter.viewControllers {
            vcs.append(chatOrganisationTabVC)
            presenter.setViewControllers(vcs, animated: false)
        } else {
            presenter.setViewControllers([chatOrganisationTabVC], animated: false)
        }
    }
}
