//
//  InitiateConversationCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 24/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class InitiateConversationCoordinator: Coordinator {
    private let presenter: UINavigationController
    private let serviceProvider: ServiceProvider
    private let initiateConversationVC: InitiateConversationVC
    
    init(presenter: UINavigationController, serviceProvider: ServiceProvider, announcement: Announcement){
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.initiateConversationVC = InitiateConversationVC.instantiate()
        self.initiateConversationVC.delegate = self
        self.initiateConversationVC.announcementVM = AnnouncementVM(announcement: announcement)
    }
    
    func start() {
        presenter.pushViewController(initiateConversationVC, animated: true)
    }
}

extension InitiateConversationCoordinator : InitiateConversationVCDelegate {
    func initiateConversationVCDidTapCancel(_ initiateConversationVC: InitiateConversationVC) {
        presenter.popViewController(animated: true)
    }
    
    func initiateConversationVCDidTapSend(_ initiateConversationVC: InitiateConversationVC) {
        
    }
}
