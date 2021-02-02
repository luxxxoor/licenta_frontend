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
    private let chat: Chat
    private var announcementCoordinator: AnnouncementCoordinator?
    
    init(presenter: UINavigationController, serviceProvider: ServiceProvider, chat: Chat){
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.conversationVC = ConversationVC.instantiate()
        self.chat = chat
        self.conversationVC.chat = chat
        self.conversationVC.delegate = self
        self.conversationVC.messages = serviceProvider.chatService.getConversation(announcementId: chat.announcementId)
    }
    
    func start() {
        presenter.pushViewController(conversationVC, animated: true)
    }
}

extension ConversationCoordinator: ConversationVCDelegate {
    func conversationVC(_ conversationVC: ConversationVC, didTap organisationName: String) {
        serviceProvider.organisationsService.getOrganisationName(top: 1, containing: chat.organisationName) {
            [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure( _): break
            case .success(let organisations):
                if let organisation = organisations.first {
                    self.serviceProvider.announcementsService.getAnnouncements(for: organisation) {
                        [weak self] result in
                        guard let self = self else { return }
                        
                        switch result {
                        case .failure( _): break
                        case .success(let announcements):
                            if let announcement = announcements.first(where: { $0.id == self.chat.announcementId }) {
                                self.announcementCoordinator = AnnouncementCoordinator(presenter: self.presenter, serviceProvider: self.serviceProvider, announcement: announcement)
                                DispatchQueue.main.async {
                                    self.announcementCoordinator?.start()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
