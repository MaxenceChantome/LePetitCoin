//
//  AppCoordinator.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 24/06/2021.
//

import Foundation

class AppCoordinator: Coordinator {
    private let router: Router
    private let services: ApiServicesType
    
    init(router: Router, services: ApiServicesType) {
        self.router = router
        self.services = services
    }

    override public func start() {
        let viewModel = ListViewModel(services: services)
        let controller = ListController(viewModel: viewModel)

        router.push(controller, animated: false)
    }
}
