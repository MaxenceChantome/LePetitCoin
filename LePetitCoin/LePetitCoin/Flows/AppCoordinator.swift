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

        controller.onSelectAd = { [weak self] ad, category in
            guard let self = self else { return }
            self.showAdController(ad, category: category)
        }
        controller.onFilter = { [weak self] categories in
            guard let self = self else { return }
            self.showFilterController(listViewModel: viewModel, categories: categories)
        }
        
        router.push(controller, animated: false)
    }
    
    private func showFilterController(listViewModel: ListViewModel, categories: Categories?) {
        let viewModel = FilterViewModel(categories: categories)
        let controller = FilterController(viewModel: viewModel)
        
        controller.onFilter = { [weak self] categories in
            guard let self = self else { return }
            self.router.dismiss(animated: true)
            // pass filtered categories to list view model in order to filter ads
            listViewModel.filterByCategories(categories)
        }
        controller.onDismiss = { [weak self] in
            guard let self = self else { return }
            self.router.dismiss(animated: true)
        }
        
        router.present(controller, animated: true)
    }
    
    private func showAdController(_ ad: Ad, category: String) {
        let viewModel = AdViewModel(ad: ad, category: category)
        let controller = AdController(viewModel: viewModel)
        
        router.push(controller, animated: true)
    }
}
