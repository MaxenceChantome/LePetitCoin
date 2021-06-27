//
//  ListViewModel.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 24/06/2021.
//

import Foundation

protocol ListViewModelType {
    // Used to show empty state view if data have been loaded and data count is empty
    var hasAlreadyLoadData: Bool { get }
    var cellCount: Int { get }
    func getCellData(at index: Int) -> ListCellViewData?
    
    func getAd(at index: Int) -> (ad: Ad, category: String)?
    
    func loadList(completion: @escaping(_ error: String?) -> Void)
}

class ListViewModel: ListViewModelType {
    // MARK: - private attributes
    private let services: ApiServicesType
    private var categories: Categories?
    private var ads: Ads? {
        didSet {
            cellData.removeAll()
            ads?.forEach { ad in
                let category = categories?.first { $0.id == ad.categoryID }?.name ?? "Inconnu"
                let date = "Le \(ad.creationDate.string(withFormat: .dayAndMonth)) à \(ad.creationDate.string(withFormat: .hourAndMinutes))"
                let url = ad.imagesURL.small != nil ? URL(string: ad.imagesURL.small ?? "") : nil
                
                let data = ListCellViewData(id: ad.id,
                                            name: ad.title,
                                            price: "\(ad.price) €",
                                            category: category,
                                            date: date,
                                            isUrgent: ad.isUrgent,
                                            imageUrl: url)
                cellData.append(data)
            }
        }
    }
    
    private var cellData = [ListCellViewData]()
    
    init(services: ApiServicesType) {
        self.services = services
    }
    
    // MARK: - protocol compliance
    var hasAlreadyLoadData = false
    
    var cellCount: Int {
        return cellData.count
    }
    
    func getCellData(at index: Int) -> ListCellViewData? {
        guard cellData.count > index else {
            return nil
        }
        return cellData[index]
    }
    
    func getAd(at index: Int) -> (ad: Ad, category: String)? {
        if cellData.count > index,
           let ad = ads?.first(where: { $0.id == cellData[index].id }) {
            return (ad: ad, category: cellData[index].category)
        }
        return nil
    }
    
    func loadList(completion: @escaping(_ error: String?) -> Void) {
        services.getCategories { reponse in
            switch reponse {
            case .success(let categories):
                self.categories = categories
                self.services.getList { response in
                    switch response {
                    case .success(let ads):
                        self.hasAlreadyLoadData = true
                        self.ads = ads
                            .sorted { $0.creationDate >  $1.creationDate }
                            .sorted { $0.isUrgent && !$1.isUrgent }
                        completion(nil)
                    case .failure(let error):
                        completion(error.localizedDescription)
                    }
                }
            case .failure(let error):
                completion(error.localizedDescription)
            }
        }
    }
}
