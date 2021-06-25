//
//  ListViewModel.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 24/06/2021.
//

import Foundation

protocol ListViewModelProtocol {
    func loadData()
}

class ListViewModel: ListViewModelProtocol {
    private let services: ApiServicesProtocol
    
    init(services: ApiServicesProtocol) {
        self.services = services
    }
    
    func loadData() {
        let group = DispatchGroup()
        
        loadList(group: group)
        loadCategories(group: group)
        group.wait()
    }
    
    private func loadList(group: DispatchGroup) {
        group.enter()
        services.getList { result in
            group.leave()
            switch result {
            case .success(let ads):
                print(ads)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func loadCategories(group: DispatchGroup) {
        group.enter()
        services.getCategories { result in
            group.leave()
            switch result {
            case .success(let ads):
                print(ads)
            case .failure(let error):
                print(error)
            }
        }
    }
}
