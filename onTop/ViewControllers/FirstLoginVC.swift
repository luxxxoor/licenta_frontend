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
    func firstLoginVC(_ firstLoginVC: FirstLoginVC, didToggleSubscribe organisation: Organisation)
    func firstLoginVC(_ firstLoginVC: FirstLoginVC, didSeach text: String?)
}

class FirstLoginVC: UIViewController, StoryboardViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var continueButton: UIButton!
    
    weak var delegate: FirstLoginVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupContinueButton()
        reloadTableView()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
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
        delegate?.firstLoginVC(self, didToggleSubscribe: organisation)
    }
    
    @IBAction private func didWriteOrganisation(_ sender: UITextField) {
        delegate?.firstLoginVC(self, didSeach: sender.text)
    }
    
    private func reloadTableView() {
        tableView.reloadData()
        
        guard let organisationsVM = organisationsVM,
            organisationsVM.organisations.count > 0
            else {
                tableView.isHidden = true
                return
        }
        
        tableView.updateConstraints()
        
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
        return organisationsVM?.organisations.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.subscribeCellIdentifier, for: indexPath)
        
        if let cell = cell as? SubscribeTableViewCell {
            organisationsVM?.configureSubscribeCell(cell, at: indexPath)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
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

