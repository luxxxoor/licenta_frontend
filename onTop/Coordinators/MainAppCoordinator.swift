//
//  MainAppCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 23/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class MainAppCoordinator: Coordinator {
    private let presenter: UINavigationController
    private let serviceProvider: ServiceProvider
    private let tabBarCoordinator: TabBarCoordinator
    private let firstLoginVC: FirstLoginVC
    
    init(presenter: UINavigationController, serviceProvider: ServiceProvider) {
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.tabBarCoordinator = TabBarCoordinator(presenter: presenter, serviceProvider: serviceProvider)
        self.firstLoginVC = FirstLoginVC.instantiate()
        
        self.firstLoginVC.delegate = self
        
        serviceProvider.organisationsService.getMostPopularOrganisations(top: 5) {
            [weak self] result in
            guard let self = self else { return }
            
            if case let Result.success(organisations) = result {
                self.firstLoginVC.organisationsVM = OrganisationsVM(organisations: organisations)
                self.serviceProvider.subscriptionService.setOrganisations(organisations: organisations)
            }
        }
    }
    
    func start() {
        presenter.pushViewController(firstLoginVC, animated: true)
    }
}

extension MainAppCoordinator: FirstLoginVCDelegate {
    func firstLoginVCDidTapContinue(_ firstLoginVC: FirstLoginVC) {
        self.tabBarCoordinator.start()
    }
    
    func firstLoginVC(_ firstLoginVC: FirstLoginVC, didToggleSubscribe organisation: Organisation) {
        serviceProvider.subscriptionService.toggleSubscription(to: organisation) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .failure(let error):
                self.firstLoginVC.showError(error)
            case .success(let organisations):
                self.firstLoginVC.organisationsVM = OrganisationsVM(organisations: organisations)
            }
        }
    }

    func firstLoginVC(_ firstLoginVC: FirstLoginVC, didSeach text: String?) {
        if let text = text, !text.isEmpty {
            serviceProvider.organisationsService.getOrganisationName(top: 5, containing: text) {
                [weak self] result in
                guard let self = self else { return }

                switch result {
                case .success(let organisations):
                    self.firstLoginVC.organisationsVM = OrganisationsVM(organisations: organisations)
                case .failure(let error):
                    self.firstLoginVC.showError(error)
                }
            }
        } else {
            serviceProvider.organisationsService.getMostPopularOrganisations(top: 5) {
                [weak self] result in
                guard let self = self else { return }

                if case let Result.success(organisations) = result {
                    self.firstLoginVC.organisationsVM = OrganisationsVM(organisations: organisations)
                }
            }
        }
    }
}
