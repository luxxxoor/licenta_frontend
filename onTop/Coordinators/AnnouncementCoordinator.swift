//
//  AnnouncementCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 23/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class AnnouncementCoordinator: Coordinator {
    private let presenter: UINavigationController
    private let serviceProvider: ServiceProvider
    private let announcementVC: AnnouncementVC
    private let announcementVM: AnnouncementVM
    private let announcement: Announcement
    private let initiateConversationCoordinator: InitiateConversationCoordinator
    weak var initiateDelegate: InitiateConversationCoordinatorDelegate? {
        didSet {
            initiateConversationCoordinator.delegate = initiateDelegate
        }
    }
    
    init(presenter: UINavigationController, serviceProvider: ServiceProvider, announcement: Announcement){
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.announcement = announcement
        self.announcementVC = AnnouncementVC.instantiate()
        self.announcementVM = AnnouncementVM(announcement: announcement, canStartConversation: serviceProvider.chatService.isChat(for: announcement.id))
        self.initiateConversationCoordinator = InitiateConversationCoordinator(presenter: presenter, serviceProvider: serviceProvider, announcement: announcement)
        self.announcementVC.delegate = self
        self.announcementVC.announcementVM = announcementVM
    }
    
    func start() {
        setupCommentsVM()
        
        presenter.pushViewController(announcementVC, animated: true)
    }
    
    private func setupCommentsVM() {
        serviceProvider.commentsService.getComments(for: announcement.id) {
            [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let comments):
                if !comments.isEmpty {
                    self.announcementVC.commentsVM = CommentsVM(comments: comments)
                }
            case .failure(let error):
                self.announcementVC.showError(error)
            }
        }
    }
}

extension AnnouncementCoordinator : AnnouncementVCDelegate {
    func announcementVCDidTapInitiateConversation(_ announcementVC: AnnouncementVC) {
        initiateConversationCoordinator.start()
    }
    
    func announcementVCDidTapBack(_ announcementVC: AnnouncementVC) {
        presenter.popViewController(animated: true)
    }
    
    func announcementVC(_ announcementVC: AnnouncementVC, didSubmit comment: String) {
        serviceProvider.commentsService.submitComment(comment, for: announcement.id) {
            [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                self.announcementVC.showError(error)
                return
            }
            
            self.setupCommentsVM()
        }
    }
}
