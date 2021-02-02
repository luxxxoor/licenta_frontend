//
//  ChatTabTableVC.swift
//  onTop
//
//  Created by Alexandru Vrincean on 04/07/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

protocol ChatTabTableVCDelegate: AnyObject {
    func chatTabTableVC(_ chatTabTableVC: ChatTabTableVC, didSelect chat: Chat)
}

class ChatTabTableVC: UIViewController, StoryboardViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    var dataSource: [Chat]? {
        didSet {
            if isViewLoaded {
                tableView.reloadData()
            }
        }
    }
    
    weak var delegate: ChatTabTableVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ChatTabTableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath)
        
        if let dataSource = dataSource {
            
            let organisationNameAttributes: [NSAttributedString.Key: Any] = [
                .font: Constants.boldFont,
                .foregroundColor: Constants.userNameColor
            ]
            let comment = NSMutableAttributedString(string: dataSource[indexPath.row].organisationName, attributes: organisationNameAttributes)
            
            let titleAttributes: [NSAttributedString.Key: Any] = [
                .font: Constants.normalFont,
                .foregroundColor: Constants.commentColor
            ]
            let commentDescription = NSMutableAttributedString(string: ": " + dataSource[indexPath.row].announcementTitle, attributes: titleAttributes)
            
            comment.append(commentDescription)
            cell.textLabel?.attributedText = comment
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataSource = dataSource else { return }
        
        let chat = dataSource[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: false)
        delegate?.chatTabTableVC(self, didSelect: chat)
    }
}

private extension ChatTabTableVC {
    enum Constants {
        static let boldFont = UIFont.boldSystemFont(ofSize: 17)
        static let userNameColor = UIColor.CustomColors.systemBlue
        static let normalFont = UIFont.systemFont(ofSize: 17)
        static let commentColor = UIColor.black
    }
}
