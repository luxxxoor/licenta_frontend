//
//  SettingsUnsubscribe.swift
//  onTop
//
//  Created by Alexandru Vrincean on 04/07/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

protocol SettingsUnsubscribeVCDelegate: AnyObject {
    func settingsUnsubscribeVCDidTapBack(_ settingsUnsubscribeVC: SettingsUnsubscribeVC)
    func settingsUnsubscribeVC(_ settingsUnsubscribeVC: SettingsUnsubscribeVC, didUnsubscribe organisation: Organisation)
}

class SettingsUnsubscribeVC: UIViewController, StoryboardViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var backButton: UIButton!
    
    weak var delegate: SettingsUnsubscribeVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupBackButton()
    }
    
    var organisationsVM: OrganisationsVM? {
        didSet {
            if isViewLoaded {
                tableView.reloadData()
            }
        }
    }
    
    private func setupBackButton() {
        backButton.setImage(#imageLiteral(resourceName: "right_arrow-icon"), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        backButton.titleLabel?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        backButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    @IBAction func didTapBack(_ sender: UIButton) {
        delegate?.settingsUnsubscribeVCDidTapBack(self)
    }
    
    @IBAction private func didTapUnsubscribe(_ sender: UIButton) {
        guard let organisationsVM = organisationsVM else { return }
        
        let organisation = organisationsVM.organisations[sender.tag]
        
        delegate?.settingsUnsubscribeVC(self, didUnsubscribe: organisation)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 45
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension SettingsUnsubscribeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(organisationsVM?.organisations.count ?? 0)
        return organisationsVM?.organisations.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.subscribeCellIdentifier, for: indexPath)
        
        if let cell = cell as? SubscribeTableViewCell {
            organisationsVM?.configureUnsubscribeCell(cell, at: indexPath)
        }
        
        return cell
    }
}

private extension SettingsUnsubscribeVC {
    enum Constants {
        static let subscribeCellIdentifier = "unsubscribeCell"
        static let boldFont = UIFont.boldSystemFont(ofSize: 17)
        static let titleColor = UIColor.white
        static let backgroundColor = UIColor.CustomColors.systemBlue
        static let cornerRadius:CGFloat = 15
    }
}

