//
//  ServiceProvider.swift
//  onTop
//
//  Created by Alexandru Vrincean on 08/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

protocol ServiceProvider {
    var announcementsService: AnnouncementsService { get }
    var organisationsService: OrganisationsService { get }
    var commentsService: CommentsService { get }
    var subscriptionService: SubscriptionService { get }
    var chatService: ChatService { get }
}
