//
//  ListViewModel.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 24/06/2021.
//

import Foundation

protocol ListViewModelProtocol {
    var cellCount: Int { get }
    func getCellData(at index: Int) -> ListCellViewData?
    
    func loadList(completion: @escaping(_ error: String?) -> Void)
    
    var reload: (() -> Void)? { get set }
}

class ListViewModel: ListViewModelProtocol {
    var reload: (() -> Void)?
    private let services: ApiServicesProtocol
    private var categories: Categories?
    private var ads: Ads? {
        didSet {
            cellData.removeAll()
            ads?.forEach { ad in
                let category = categories?.first { $0.id == ad.categoryID }?.name ?? "Inconnu"
                let date = "Le \(ad.creationDate.string(withFormat: .dayAndMonth)) à \(ad.creationDate.string(withFormat: .hourAndMinutes))"
                let data = ListCellViewData(name: ad.title,
                                            price: "\(ad.price) €",
                                            category: category,
                                            date: date,
                                            isUrgent: ad.isUrgent,
                                            thumbUrl: nil)
                cellData.append(data)
            }
            self.reload?()
        }
    }
    
    private var cellData = [ListCellViewData]()
    
    init(services: ApiServicesProtocol) {
        self.services = services
    }
    
    func loadList(completion: @escaping(_ error: String?) -> Void) {
        services.getCategories { reponse in
            switch reponse {
            case .success(let categories):
                self.categories = categories
                self.services.getList { response in
                    switch response {
                    case .success(let ads):
                        self.ads = ads
                            .sorted { $0.creationDate >  $1.creationDate }
                            .sorted { $0.isUrgent && !$1.isUrgent }
                    case .failure(let error):
                        completion(error.localizedDescription)
                    }
                }
            case .failure(let error):
                completion(error.localizedDescription)
            }
        }
    }
    
    var cellCount: Int {
        return cellData.count
    }
    
    func getCellData(at index: Int) -> ListCellViewData? {
        guard cellData.count > index else {
            return nil
        }
        return cellData[index]
    }
}
