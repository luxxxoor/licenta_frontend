//
//  InitiateConversation.swift
//  onTop
//
//  Created by Alexandru Vrincean on 24/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

protocol InitiateConversationVCDelegate: AnyObject {
    func initiateConversationVCDidTapCancel(_ initiateConversationVC: InitiateConversationVC)
    func initiateConversationVCDidTapSend(_ initiateConversationVC: InitiateConversationVC)

}

class InitiateConversationVC: UIViewController, StoryboardViewController {
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var sendButton: UIButton!
    @IBOutlet private weak var organisationLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var announcementVM: AnnouncementVM? {
        didSet {
            if isViewLoaded {
                setupAnnouncement()
            }
        }
    }
    
    weak var delegate: InitiateConversationVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAnnouncement()
        setupButtons()
    }
    
    @IBAction private func didTapCancel(_ sender: UIButton) {
        delegate?.initiateConversationVCDidTapCancel(self)
    }
    
    
    @IBAction private func didTapSend(_ sender: UIButton) {
        delegate?.initiateConversationVCDidTapSend(self)
    }
    
    @IBAction private func didWrite(_ sender: UITextField) {
        if let text = sender.text, !text.isEmpty {
            sendButton.isEnabled = true
        } else {
            sendButton.isEnabled = false
        }
    }
    
    private func setupAnnouncement() {
        announcementVM?.setDescriptionLabel(descriptionLabel, superView: descriptionLabel)
        announcementVM?.setImageView(imageView)
        announcementVM?.setOrganisationNameLabel(organisationLabel)
        announcementVM?.setDateLabel(dateLabel)
    }
    
    private func setupButtons() {
        cancelButton.setImage(#imageLiteral(resourceName: "right_arrow-icon"), for: .normal)
        cancelButton.imageView?.contentMode = .scaleAspectFit
        cancelButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        cancelButton.titleLabel?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        cancelButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        sendButton.setImage(#imageLiteral(resourceName: "right_arrow-icon"), for: .normal)
        sendButton.imageView?.contentMode = .scaleAspectFit
        sendButton.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        sendButton.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        sendButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: -1.0)
    }
}
