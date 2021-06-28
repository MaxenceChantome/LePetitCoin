//
//  ListTests.swift
//  LePetitCoinTests
//
//  Created by Maxence Chantôme on 28/06/2021.
//

import Foundation
import XCTest

@testable import LePetitCoin

class ListTests: XCTestCase {
    var viewModel: ListViewModelType!
    
    override func setUp() {
        super.setUp()
        let services = MockApiServices()
        viewModel = ListViewModel(services: services)
        
        let expectation = self.expectation(description: "Load categories and listing")
        
        viewModel.loadList { error in
            if let error = error {
                XCTFail("Loading data: \(error)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testsCategories() {
        guard let category = viewModel.categories?[2] else {
            XCTFail("Category not found")
            return
        }
        XCTAssertEqual(viewModel.categories?.count, 11)
        XCTAssertEqual(category.name, "Bricolage")
        XCTAssertEqual(category.id, 3)
        XCTAssertEqual(category.isSelected, false)
    }
    
    func testCellData() {
        guard let cellData = viewModel.getCellData(at: 4) else {
            XCTFail("Cell data not found")
            return
        }
        XCTAssertEqual(viewModel.rowCount, 6)
        XCTAssertEqual(cellData.id, 1664493117)
        XCTAssertEqual(cellData.category, "Service")
        XCTAssertEqual(cellData.date, "Le 05/11 à 16:56")
        XCTAssertEqual(cellData.isUrgent, false)
        XCTAssertEqual(cellData.name, "Professeur natif d'espagnol à domicile")
        XCTAssertEqual(cellData.price, "25 €")
        XCTAssertEqual(cellData.imageUrl?.absoluteString, "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/af9c43ff5a3b3692f9f1aa3c17d7b46d8b740311.jpg")
    }
    
    func testAd() {
        guard let adInfos = viewModel.getAd(at: 2) else {
            XCTFail("Ad not found")
            return
        }
        XCTAssertEqual(adInfos.category, "Enfants")
        XCTAssertEqual(adInfos.ad.title, "Bouillotte Dodie")
        XCTAssertEqual(adInfos.ad.adDescription, "Bouillotte gel pour bébé.")
        XCTAssertEqual(adInfos.ad.isUrgent, true)
        XCTAssertEqual(adInfos.ad.price, 5)
        XCTAssertEqual(adInfos.ad.creationDate, "2019-11-05T16:55:54+0000".iso8601Date())
        XCTAssertEqual(adInfos.ad.categoryID, 11)
    }
}
