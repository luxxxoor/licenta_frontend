//
//  ServiceFactory.swift
//  onTop
//
//  Created by Alexandru Vrincean on 08/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

final class ServiceFactory: ServiceProvider {
    let loginService = LoginService(remote: LoginHttpRemotService())
    let registerService = RegisterService(remote: RegisterHttpRemotService())
    let announcementsService = AnnouncementsService(remote: AnnouncementsRealService())
}
