//
//  ServiceMockedFactory.swift
//  onTop
//
//  Created by Alexandru Vrincean on 08/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

final class ServiceMockFactory: ServiceProvider {
    let announcementsService = AnnouncementsService(remote: AnnouncementsRemoteServiceMock())
    let organisationsService = OrganisationsService(remote: OrganisationsRemoteServiceMock())
    let commentsService = CommentsService(remote: CommentsRemoteServiceMock())
    let subscriptionService = SubscriptionService(remote: SubscriptionRemoteServiceMock())
    let chatService = ChatService()
}
