//
//  ChatTabTableCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 04/07/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class ChatTabTableCoordinator: Coordinator {
    private let presenter: UITabBarController
    private let serviceProvider: ServiceProvider
    private let navigationVC: UINavigationController
    private let chatTabTableVC: ChatTabTableVC
    private var conversationCoordinator: ConversationCoordinator?
    
    init(presenter: UITabBarController, serviceProvider: ServiceProvider){
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.navigationVC = UINavigationController()
        self.chatTabTableVC = ChatTabTableVC.instantiate()
        self.chatTabTableVC.delegate = self
        self.chatTabTableVC.dataSource = serviceProvider.chatService.getChats()
        
        let icon = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "chat-icon"), selectedImage: nil)
        self.chatTabTableVC.tabBarItem = icon
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
        
        navigationVC.pushViewController(chatTabTableVC, animated: true)
    }
}

extension ChatTabTableCoordinator: ChatTabTableVCDelegate {
    func chatTabTableVC(_ chatTabTableVC: ChatTabTableVC, didSelect chat: Chat) {
        conversationCoordinator = ConversationCoordinator(presenter: navigationVC, serviceProvider: serviceProvider, chat: chat)
        conversationCoordinator?.start()
    }
}

extension ChatTabTableCoordinator: InitiateConversationCoordinatorDelegate {
    func initiateConversationCoordinator(_ initiateConversationCoordinator: InitiateConversationCoordinator) {
        presenter.selectedIndex = 2
        self.chatTabTableVC.dataSource = serviceProvider.chatService.getChats()
    }
}
