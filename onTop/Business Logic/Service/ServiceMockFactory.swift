//
//  ServiceMockedFactory.swift
//  onTop
//
//  Created by Alexandru Vrincean on 08/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

final class ServiceMockFactory: ServiceProvider {
    let loginService = LoginService(remote: LoginRemoteServiceMock())
    let registerService = RegisterService(remote: RegisterRemoteServiceMock())
    let announcementsService = AnnouncementsService(remote: AnnouncementsRemoteServiceMock())
}
