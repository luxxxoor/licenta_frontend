//
//  ServiceFactory.swift
//  onTop
//
//  Created by Alexandru Vrincean on 08/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

final class ServiceFactory: ServiceProvider {
    let announcementsService = AnnouncementsService(remote: AnnouncementsRemoteServiceReal())
    let organisationsService = OrganisationsService(remote: OrganisationsRemoteServiceReal())
    let commentsService = CommentsService(remote: CommentsRemoteServiceReal())
    let subscriptionService = SubscriptionService(remote: SubscriptionRemoteServiceReal())
    let chatService = ChatService()
}
