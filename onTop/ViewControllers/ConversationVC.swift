//
//  ConversationVC.swift
//  onTop
//
//  Created by Alexandru Vrincean on 24/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

protocol ConversationVCDelegate: AnyObject {
    func conversationVC(_ conversationVC: ConversationVC, didTap organisationName: String)
}

class ConversationVC: UIViewController, StoryboardViewController {
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var organisationLabel: UILabel!
    @IBOutlet private weak var announcementTitleButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    var chat: Chat!
    var messages: [Message] = []
    weak var delegate: ConversationVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        organisationLabel.text = chat.organisationName
        announcementTitleButton.setTitle(chat.announcementTitle, for: .normal)
        
        setupBackButton()
    }
    
    @IBAction private func didPressBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapOnConversation(_ sender: UIButton) {
        delegate?.conversationVC(self, didTap: chat.organisationName)
    }
    
    private func setupBackButton() {
        backButton.setImage(#imageLiteral(resourceName: "right_arrow-icon"), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        backButton.titleLabel?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        backButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        announcementTitleButton.layer.borderColor = UIColor.CustomColors.systemBlue.cgColor
        announcementTitleButton.layer.borderWidth = 1
        announcementTitleButton.backgroundColor = .white
    }
}

extension ConversationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "conversationCell", for: indexPath)
        
        if let cell = cell as? MessageTableViewCell {
            let index = indexPath.row
            cell.messageLabel.text = messages[index].text
            cell.messageLabel.layer.masksToBounds = true
            if !messages[index].isUser {
                cell.messageLeadingConstraint.isActive = false
                cell.messageLeadingConstraint = cell.messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: cell.leadingAnchor, constant: 100)
                cell.messageLeadingConstraint.isActive = true
                
                cell.messageTrailingConstraint.isActive = false
                cell.messageTrailingConstraint = cell.messageLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor)
                cell.messageTrailingConstraint.isActive = true
                
                cell.messageLabel.textColor = .black
                cell.messageLabel.backgroundColor = UIColor.CustomColors.lightGray
            }
        }
        
        return cell
    }
    
    
}
