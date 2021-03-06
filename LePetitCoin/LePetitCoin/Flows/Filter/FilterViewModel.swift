//
//  FilterViewModel.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 27/06/2021.
//

import Foundation

protocol FilterViewModelType {
    init(categories: Categories?)
    
    /// Return indexes of selected categories in order to pre select them in the tableview
    var cellSelectedRows: [Int]? { get }
    
    var categories: Categories? { get }
    
    var rowCount: Int { get }
    
    func getCategory(at index: Int) -> CategoryCellViewData?
    func selectCategory(at index: Int, selected: Bool)
}

class FilterViewModel: FilterViewModelType {
    
    required init(categories: Categories?) {
        // sort categories by id to have a more clean and predictable behavior
        self.categories = categories?.sorted { $0.id < $1.id }
    }
    
    var categories: Categories?
    
    var cellSelectedRows: [Int]? {
        // get indexes of categories where isSelected = true
        return categories?.enumerated()
            .filter { $0.element.isSelected ?? false }
            .map { $0.offset }
    }
    
    var rowCount: Int {
        return categories?.count ?? 0
    }
    
    func getCategory(at index: Int) -> CategoryCellViewData? {
        guard let categories = categories, categories.count > index else {
            return nil
        }
        return CategoryCellViewData(name: categories[index].name)
    }
    
    func selectCategory(at index: Int, selected: Bool) {
        guard let categories = categories, categories.count > index else {
            return
        }
        
        self.categories?[index].isSelected = selected
    }
}
