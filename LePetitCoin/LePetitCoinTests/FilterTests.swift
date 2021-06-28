//
//  FilterTests.swift
//  LePetitCoinTests
//
//  Created by Maxence Chantôme on 28/06/2021.
//

import Foundation
import XCTest

@testable import LePetitCoin

class FilterTests: XCTestCase {
    var viewModel: FilterViewModelType!
    
    override func setUp() {
        super.setUp()
        let services = MockApiServices()
        let expectation = self.expectation(description: "Load categories")
        
        // load categories from mock api
        services.getCategories { response in
            switch response {
            case .success( let categories):
                self.viewModel = FilterViewModel(categories: categories)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Loading data: \(error.localizedDescription)")
            }
        }
      
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testCategories() {
        guard let category =  viewModel.getCategory(at: 3) else {
            XCTFail("Category not found")
            return
        }
        XCTAssertEqual(viewModel.rowCount, 11)
        XCTAssertEqual(category.name, "Maison")
    }
    
    func testCategorySelection() {
        XCTAssertEqual(viewModel.cellSelectedRows, [])
        viewModel.selectCategory(at: 2, selected: true)
        viewModel.selectCategory(at: 4, selected: true)
        XCTAssertEqual(viewModel.cellSelectedRows, [2, 4])
        viewModel.selectCategory(at: 4, selected: false)
        XCTAssertEqual(viewModel.cellSelectedRows, [2])
    }
}
