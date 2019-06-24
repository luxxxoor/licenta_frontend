//
//  ConversationCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 24/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit 


class ConversationCoordinator: Coordinator {
    private let presenter: UINavigationController
    private let serviceProvider: ServiceProvider
    private let conversationVC: ConversationVC
    
    init(presenter: UINavigationController, serviceProvider: ServiceProvider){
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.conversationVC = ConversationVC.instantiate()
    }
    
    func start() {
        presenter.pushViewController(conversationVC, animated: true)
    }
}
