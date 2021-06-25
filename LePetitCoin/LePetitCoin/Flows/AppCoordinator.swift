//
//  AppCoordinator.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 24/06/2021.
//

import Foundation

class AppCoordinator: Coordinator {
    private let router: Router
    private let services: ApiServices
    
    init(router: Router, services: ApiServices) {
        self.router = router
        self.services = ApiServices()
    }

    override public func start() {
        let viewModel = ListViewModel(services: services)
        let controller = ListController(viewModel: viewModel)

        router.push(controller, animated: false)
    }
}
