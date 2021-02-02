//
//  InitiateConversationCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 24/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

protocol InitiateConversationCoordinatorDelegate: AnyObject {
    func initiateConversationCoordinator(_ initiateConversationCoordinator: InitiateConversationCoordinator)
}

class InitiateConversationCoordinator: Coordinator {
    private let presenter: UINavigationController
    private let serviceProvider: ServiceProvider
    private let initiateConversationVC: InitiateConversationVC
    weak var delegate: InitiateConversationCoordinatorDelegate?
    
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
    
    func initiateConversationVCDidTapSend(_ initiateConversationVC: InitiateConversationVC, chat: Chat, message: Message) {
        serviceProvider.chatService.createChat(announcementId: chat.announcementId, organisationName: chat.organisationName, announcementTitle: chat.announcementTitle)
        serviceProvider.chatService.addMessage(announcementId: chat.announcementId, message: message)
        delegate?.initiateConversationCoordinator(self)
        presenter.popViewController(animated: false)
        presenter.popViewController(animated: false)
    }
}
