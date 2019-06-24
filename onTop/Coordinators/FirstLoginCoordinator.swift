//
//  FirstLoginCoordinator.swift
//  onTop
//
//  Created by Alexandru Vrincean on 23/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class FirstLoginCoordinator: Coordinator {
    private let presenter: UINavigationController
    private let serviceProvider: ServiceProvider
    private let registerCoordinator: RegisterCoordinator
    private let tabBarCoordinator: TabBarCoordinator
    private let firstLoginVC: FirstLoginVC
    
    init(presenter: UINavigationController, serviceProvider: ServiceProvider) {
        self.presenter = presenter
        self.serviceProvider = serviceProvider
        self.registerCoordinator = RegisterCoordinator(presenter: presenter, serviceProvider: serviceProvider)
        self.tabBarCoordinator = TabBarCoordinator(presenter: presenter, serviceProvider: serviceProvider)
        self.firstLoginVC = FirstLoginVC.instantiate()
        
        self.firstLoginVC.delegate = self
    }
    
    func start() {
        presenter.pushViewController(firstLoginVC, animated: true)
    }
}

extension FirstLoginCoordinator: FirstLoginVCDelegate {
    func firstLoginVCDidTapContinue(_ firstLoginVC: FirstLoginVC) {
        self.tabBarCoordinator.start()
    }
    
    func firstLoginVC(_ firstLoginVC: FirstLoginVC, didSubscribe organisation: Organisation) {
        #warning("change this when backend is online")
        
        if var organisations = firstLoginVC.organisationsVM?.organisations.filter({ $0.name != organisation.name }),
            let id = firstLoginVC.organisationsVM?.organisations.firstIndex(where: { $0.name == organisation.name }){
            organisations.insert(Organisation(id: organisation.id, name: organisation.name, isUserSubscriber: !organisation.isUserSubscriber), at: id)
            self.firstLoginVC.organisationsVM = OrganisationsVM(organisations: organisations)
        }
        
    }
    
    func firstLoginVC(_ firstLoginVC: FirstLoginVC, didSeach text: String) {
        serviceProvider.organisationsService.getOrganisationName(containing: text) {
            [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let organisations):
                self.firstLoginVC.organisationsVM = OrganisationsVM(organisations: organisations)
            case .failure(let error):
                self.firstLoginVC.showError(error)
            }
        }
    }
}
