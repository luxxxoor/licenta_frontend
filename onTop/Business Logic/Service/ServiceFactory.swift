//
//  ServiceFactory.swift
//  onTop
//
//  Created by Alexandru Vrincean on 08/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

final class ServiceFactory: ServiceProvider {
    let loginService = LoginService(remote: LoginRemoteServiceReal())
    let registerService = RegisterService(remote: RegisterRemoteServiceReal())
    let announcementsService = AnnouncementsService(remote: AnnouncementsRemoteServiceReal())
}
