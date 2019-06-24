//
//  AnnouncementVC.swift
//  onTop
//
//  Created by Alexandru Vrincean on 23/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

protocol AnnouncementVCDelegate : AnyObject {
    func announcementVCDidTapBack(_ announcementVC: AnnouncementVC)
    func announcementVCDidTapInitiateConversation(_ announcementVC: AnnouncementVC)
}

class AnnouncementVC : UIViewController, StoryboardViewController {
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var descriptionViewWrapper: UIView!
    @IBOutlet private weak var commentsView: UIView!
    @IBOutlet private weak var commentsTableView: UITableView!
    @IBOutlet private weak var commentTextBox: UITextField!
    @IBOutlet private weak var viewMoreButton: UIButton!
    @IBOutlet private weak var scrollViewInner: UIView!
    @IBOutlet private weak var scrollViewInnerHeight: NSLayoutConstraint!
    @IBOutlet private weak var announcementStackView: UIStackView!
    @IBOutlet private weak var startConversationButton: UIButton!
    @IBOutlet private weak var commentsTableViewHeightConstraint: NSLayoutConstraint!
    
    weak var delegate: AnnouncementVCDelegate?
    
    var announcementVM: AnnouncementVM? {
        didSet {
            if isViewLoaded {
                setupAnnouncement()
            }
        }
    }
    var commentsVM: CommentsVM? {
        didSet {
            if isViewLoaded {
                setupComments()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupBackButton()
        setupAnnouncement()
        setupComments()
        setupConversationButton()
        
        #warning("ask mihai #2")
        scrollViewInnerHeight.isActive =  false
        scrollViewInner.heightAnchor.constraint(equalToConstant: announcementStackView.bounds.height)
    }
    @IBAction private func didTapInitConversation(_ sender: UIButton) {
        delegate?.announcementVCDidTapInitiateConversation(self)
    }
    
    @IBAction private func didTapBack(_ sender: UIButton) {
        delegate?.announcementVCDidTapBack(self)
    }
    
    @IBAction private func didTapViewMore(_ sender: Any) {
        descriptionLabel.numberOfLines = 0
        viewMoreButton.isHidden = true
    }
    
    private func setupBackButton() {
        backButton.setImage(#imageLiteral(resourceName: "right_arrow-icon"), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        backButton.titleLabel?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        backButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    private func setupAnnouncement() {
        guard let announcementVM = announcementVM else { return }
        
        announcementVM.setTitleLabel(titleLabel)
        announcementVM.setImageView(imageView)
        announcementVM.setDescriptionLabel(descriptionLabel, superView: descriptionViewWrapper)
    }
    
    private func setupTableView() {
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        commentsTableView.estimatedRowHeight = 50
        commentsTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupComments() {
        
        reloadTableView()
        
        if commentsVM != nil {
            commentTextBox.placeholder = Constants.textBoxPlaceHolder
        }
    }
    
    private func setupConversationButton() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Constants.boldFont,
            .foregroundColor: Constants.titleColor
        ]
        
        let buttonAttributedTitle = NSMutableAttributedString(string: Constants.titleStartConversation, attributes: attributes)
        
        startConversationButton.backgroundColor = Constants.backgroundColor
        startConversationButton.layer.cornerRadius = Constants.cornerRadius
        startConversationButton.setAttributedTitle(buttonAttributedTitle, for: .normal)
    }
    
    private func reloadTableView() {
        commentsTableView.reloadData()
        
        guard let commentsVM = commentsVM,
            commentsVM.comments.count > 0
            else {
                commentsView.isHidden = true
                return
        }
        
        let size = commentsTableView.visibleCells.map { $0.bounds.height }.reduce(0, +)
        
        commentsTableViewHeightConstraint.isActive = false
        commentsTableViewHeightConstraint = commentsTableView.heightAnchor.constraint(equalToConstant: size)
        commentsTableViewHeightConstraint.priority = .defaultHigh
        commentsTableViewHeightConstraint.isActive = true
        
        commentsView.isHidden = false
    }
}

extension AnnouncementVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsVM?.comments.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.commentCellIdentifier, for: indexPath)
        
        if let cell = cell as? CommentTableViewCell {
            commentsVM?.configureCell(cell, at: indexPath)
        }
        
        return cell
    }
}

private extension AnnouncementVC {
    enum Constants {
        static let commentCellIdentifier = "commentCell"
        static let textBoxPlaceHolder = "Lasă un comentariu..."
        static let titleStartConversation = "Începe o conversație."
        static let boldFont = UIFont.boldSystemFont(ofSize: 17)
        static let titleColor = UIColor.white
        static let backgroundColor = UIColor.CustomColors.systemBlue
        static let cornerRadius:CGFloat = 15
    }
}
