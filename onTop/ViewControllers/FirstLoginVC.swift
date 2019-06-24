//
//  FirstLoginVC.swift
//  onTop
//
//  Created by Alexandru Vrincean on 23/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

protocol FirstLoginVCDelegate: AnyObject {
    func firstLoginVCDidTapContinue(_ firstLoginVC: FirstLoginVC)
    func firstLoginVC(_ firstLoginVC: FirstLoginVC, didSubscribe organisation: Organisation)
    func firstLoginVC(_ firstLoginVC: FirstLoginVC, didSeach text: String)
}

class FirstLoginVC: UIViewController, StoryboardViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var continueButton: UIButton!
    
    weak var delegate: FirstLoginVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupContinueButton()
    }
    
    var organisationsVM: OrganisationsVM? {
        didSet {
            if isViewLoaded {
                reloadTableView()
            }
        }
    }
    
    @IBAction func didTapContinue(_ sender: UIButton) {
        delegate?.firstLoginVCDidTapContinue(self)
    }
    
    @IBAction private func didToggleSubscribe(_ sender: UIButton) {
        guard let organisationsVM = organisationsVM else { return }
        
        let organisation = organisationsVM.organisations[sender.tag]
        
        delegate?.firstLoginVC(self, didSubscribe: organisation)
    }
    
    @IBAction private func didWriteOrganisation(_ sender: UITextField) {
        if let text = sender.text, !text.isEmpty {
            delegate?.firstLoginVC(self, didSeach: text)
        } else {
            tableView.isHidden =  true
        }
    }
    
    private func reloadTableView() {
        #warning("nu apare tot ce naiba")
        tableView.reloadData()
        
        guard let organisationsVM = organisationsVM,
            organisationsVM.organisations.count > 0
            else {
                tableView.isHidden = true
                return
        }
        
        let size = tableView.visibleCells.map { $0.bounds.height }.reduce(0, +)
        
        tableViewHeightConstraint.isActive = false
        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: size)
        tableViewHeightConstraint.priority = .defaultHigh
        tableViewHeightConstraint.isActive = true
        
        tableView.isHidden = false
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 45
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupContinueButton() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Constants.boldFont,
            .foregroundColor: Constants.titleColor
        ]
        
        let buttonAttributedTitle = NSMutableAttributedString(string: "Continuă", attributes: attributes)
        
        continueButton.backgroundColor = Constants.backgroundColor
        continueButton.layer.cornerRadius = Constants.cornerRadius
        continueButton.setAttributedTitle(buttonAttributedTitle, for: .normal)
    }
}

extension FirstLoginVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(organisationsVM?.organisations.count ?? 0) ce naiba")
        return organisationsVM?.organisations.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.subscribeCellIdentifier, for: indexPath)
        
        if let cell = cell as? SubscribeTableViewCell {
            organisationsVM?.configureSubscribeCell(cell, at: indexPath)
        }
        
        return cell
    }
}

private extension FirstLoginVC {
    enum Constants {
        static let subscribeCellIdentifier = "subscribeCell"
        static let boldFont = UIFont.boldSystemFont(ofSize: 17)
        static let titleColor = UIColor.white
        static let backgroundColor = UIColor.CustomColors.systemBlue
        static let cornerRadius:CGFloat = 15
    }
}

