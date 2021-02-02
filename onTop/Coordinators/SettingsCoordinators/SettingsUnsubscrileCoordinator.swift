//
//  SettingsUnsubscrileCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 04/07/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class SettingsUnsubscribeCoordinator: Coordinator {
    private let presenter: UINavigationController
    private let serviceProvider: ServiceProvider
    private let settingsUnsubscribeVC: SettingsUnsubscribeVC
    
    init(presenter: UINavigationController, serviceProvider: ServiceProvider) {
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.settingsUnsubscribeVC = SettingsUnsubscribeVC.instantiate()
        
        self.settingsUnsubscribeVC.delegate = self
    }
    
    func start() {
        setSubscribedOrganisations()
        presenter.pushViewController(settingsUnsubscribeVC, animated: true)
    }
    
    private func setSubscribedOrganisations() {
        serviceProvider.subscriptionService.getSubscribedOrganisations() {
            [weak self] result in
            guard let self = self else { return }
            
            if case let Result.success(organisations) = result {
                self.settingsUnsubscribeVC.organisationsVM = OrganisationsVM(organisations: organisations)
            }
        }
    }
}

extension SettingsUnsubscribeCoordinator: SettingsUnsubscribeVCDelegate {
    func settingsUnsubscribeVCDidTapBack(_ settingsUnsubscribeVC: SettingsUnsubscribeVC) {
        presenter.popViewController(animated: true)
    }
    
    func settingsUnsubscribeVC(_ settingsUnsubscribeVC: SettingsUnsubscribeVC, didUnsubscribe organisation: Organisation) {
        
        serviceProvider.subscriptionService.toggleSubscription(to: organisation) {
            [weak self] result in
            guard let self = self else { return }

            switch result {
            case .failure(let error):
                self.settingsUnsubscribeVC.showError(error)
            case .success(let organisations):
                self.settingsUnsubscribeVC.organisationsVM = OrganisationsVM(organisations: organisations)
            }
        }
        
    }
}
