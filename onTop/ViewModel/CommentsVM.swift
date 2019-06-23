//
//  CommentsVM.swift
//  onTop
//
//  Created by Alexandru Vrincean on 23/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class CommentsVM {
    private(set) var comments: [Comment]
    
    init(comments: [Comment]) {
        self.comments = comments
    }
    
    func configureCell(_ cell: CommentTableViewCell, at indexPath: IndexPath) {
        let userName = comments[indexPath.row].userName
        let description = comments[indexPath.row].description
        
        let userNameAttributes: [NSAttributedString.Key: Any] = [
            .font: Constants.boldFont,
            .foregroundColor: Constants.userNameColor
        ]
        let comment = NSMutableAttributedString(string: userName, attributes: userNameAttributes)
        
        let descriptionAttributes: [NSAttributedString.Key: Any] = [
            .font: Constants.normalFont,
            .foregroundColor: Constants.commentColor
        ]
        let commentDescription = NSMutableAttributedString(string: ": " + description, attributes: descriptionAttributes)
        
        comment.append(commentDescription)
        cell.commentLabel.attributedText = comment
    }
}

private extension CommentsVM {
    enum Constants {
        static let boldFont = UIFont.boldSystemFont(ofSize: 17)
        static let userNameColor = UIColor.CustomColors.systemBlue
        static let normalFont = UIFont.systemFont(ofSize: 17)
        static let commentColor = UIColor.black
    }
}
