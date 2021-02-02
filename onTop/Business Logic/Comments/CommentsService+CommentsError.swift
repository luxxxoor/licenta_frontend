//
//  CommentsService+CommentsError.swift
//  onTop
//
//  Created by Alexandru Vrincean on 04/07/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

extension CommentsService {
    enum CommentError: LocalizedError {
        case announcementNotFound
        case serverError
        
        var errorDescription: String? {
            switch self {
            case .serverError:
                return "A apărul o eroare la server. Operația a fost anulată."
            case .announcementNotFound:
                return "Anunțul nu există."
            }
        }
    }
}
