//
//  SearchOrganisationTabVC.swift
//  onTop
//
//  Created by Alexandru Vrincean on 22/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

protocol SearchOrganisationTabVCDelegate: AnyObject {
    func searchOrganisationTabVC(_ searchOrganisationTabVC: SearchOrganisationTabVC,
                                 didSearchFor text: String)
    func searchOrganisationTabVC(_ searchOrganisationTabVC: SearchOrganisationTabVC,
                                 didSelectOrganisation organisation: String)
    
    func searchOrganisationTabVCDidToggleSubscribe(_ searchOrganisationTabVC: SearchOrganisationTabVC)
}

class SearchOrganisationTabVC: UIViewController, StoryboardViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableSizeConstraint: NSLayoutConstraint!
    @IBOutlet private weak var textFieldWrapper: UIView!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var subscribeButton: UIButton!
    
    weak var delegate: SearchOrganisationTabVCDelegate?
    
    var organisationsTabVM: OrganisationsTabVM? {
        didSet {
            if isViewLoaded {
                reloadTableView()
            }
        }
    }
    var announcementsTabVM: AnnouncementsTabVM? {
        didSet {
            if isViewLoaded {
                announcementsTabVM?.configureSubscribeButton(subscribeButton)
                collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupCollectionView()
        setupSearchTextBox()
        setupSubscribeButton()
    }
    
    @IBAction func didWriteText(_ sender: UITextField) {
        guard let text = sender.text, !text.isEmpty else {
            tableView.isHidden = true
            return
        }
        
        delegate?.searchOrganisationTabVC(self, didSearchFor: text)
    }
    
    @IBAction func didToggleSubscribe(_ sender: UIButton) {
        delegate?.searchOrganisationTabVCDidToggleSubscribe(self)
    }
    
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = Constants.cornerRadius
        tableView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.bringSubviewToFront(tableView)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.decelerationRate = .fast
    }
    
    private func setupSearchTextBox() {
        textFieldWrapper.layer.cornerRadius = Constants.cornerRadius
        textFieldWrapper.layer.borderWidth = Constants.borderWidth
        textFieldWrapper.layer.borderColor = Constants.textFieldColor
        searchTextField.borderStyle = .none
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: Constants.searchImageWidth, height: Constants.searchImageHeight))
        imageView.image = #imageLiteral(resourceName: "search_bar-icon")
        imageView.contentMode = .left
        let view = UIView(frame: CGRect(x: 0, y:0, width: Constants.searchImageWidth + Constants.searchImageDistanceToNextView, height: Constants.searchImageHeight))
        view.addSubview(imageView)
        searchTextField.leftView = view
        searchTextField.leftViewMode = .unlessEditing
    }
    
    private func reloadTableView() {
        tableView.reloadData()
        
        guard let organisationsTabVM = organisationsTabVM,
            organisationsTabVM.organisations.count > 0
            else {
            tableView.isHidden = true
            return
        }
        
        let size = tableView.visibleCells.map { $0.bounds.height }.reduce(0, +)
        
        tableSizeConstraint.isActive = false
        tableSizeConstraint = tableView.heightAnchor.constraint(equalToConstant: size)
        tableSizeConstraint.priority = .defaultHigh
        tableSizeConstraint.isActive = true
        
        tableView.isHidden = false
    }
    
    private func setupSubscribeButton() {
        subscribeButton.backgroundColor = Constants.subscribeButtonColor
        subscribeButton.titleLabel?.numberOfLines = 1;
        subscribeButton.titleLabel?.adjustsFontSizeToFitWidth = true;
        subscribeButton.titleLabel?.lineBreakMode = .byClipping;
        subscribeButton.layer.cornerRadius = 4
    }
}

extension SearchOrganisationTabVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return announcementsTabVM?.announcements.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.announcementCellIdentifier, for: indexPath)
        
        if let cell = cell as? AnnouncementHeadlineCollectionViewCell {
            announcementsTabVM?.configureCell(cell, at: indexPath)
        }
        
        return cell
    }
}

extension SearchOrganisationTabVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organisationsTabVM?.organisations.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.organisationCellIdentifier, for: indexPath)
        
        organisationsTabVM?.configureCell(cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableViewRowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let organisationsTabVM = organisationsTabVM else { return }
        
        let organisation = organisationsTabVM.organisations[indexPath.row]
        
        delegate?.searchOrganisationTabVC(self, didSelectOrganisation: organisation)
        searchTextField.text = nil
    }
}

extension SearchOrganisationTabVC {
    enum Constants {
        static let announcementCellIdentifier = "announcementsCell"
        static let organisationCellIdentifier = "organisationsCell"
        static let searchImageWidth: CGFloat = 24.0
        static let searchImageHeight: CGFloat = 24.0
        static let searchImageDistanceToNextView: CGFloat = 16.0
        static let tableViewRowHeight: CGFloat = 40.0
        static let cornerRadius: CGFloat =  15
        static let borderWidth: CGFloat = 1
        static let textFieldColor = UIColor.CustomColors.systemBlue.cgColor
        static let subscribeButtonColor = UIColor.CustomColors.systemBlue
        static let tableViewMaxCell = 4
    }
}

private extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = frame
        rectShape.position = center
        rectShape.path = UIBezierPath(roundedRect: bounds,
                                      byRoundingCorners: corners,
                                      cornerRadii: CGSize(width: radius, height: radius)).cgPath
        layer.mask = rectShape
    }
}
