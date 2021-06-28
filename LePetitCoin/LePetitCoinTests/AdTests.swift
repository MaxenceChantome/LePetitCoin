//
//  AdTests.swift
//  LePetitCoinTests
//
//  Created by Maxence Chantôme on 28/06/2021.
//

import Foundation
import XCTest

@testable import LePetitCoin

class AdTests: XCTestCase {
    var viewModel: AdViewModelType!
    
    override func setUp() {
        super.setUp()
        let services = MockApiServices()
        let expectation = self.expectation(description: "Load list")
        
        // load list from mock api
        services.getList { response in
            switch response {
            case .success( let list):
                self.viewModel = AdViewModel(ad: list[3], category: "Mode")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Loading data: \(error.localizedDescription)")
            }
        }
      
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testImageData() {
        XCTAssertEqual(viewModel.imageViewData.imageUrl, URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/5ae4741dabd3a236cbfb8b6a5746acba6823e41e.jpg"))
        XCTAssertEqual(viewModel.imageViewData.isUrgent, true)
    }

    func testInfosData() {
        XCTAssertEqual(viewModel.infosViewData.category, "Mode")
        XCTAssertEqual(viewModel.infosViewData.date, "Posté le 05/11 à 16:56")
        XCTAssertEqual(viewModel.infosViewData.name, "Ensemble fille 1 mois NEUF")
        XCTAssertEqual(viewModel.infosViewData.price, "5 €")
        XCTAssertEqual(viewModel.infosViewData.siret, nil)
    }
    
    func testDescription() {
        XCTAssertEqual(viewModel.description, "Vends Robe avec t-shirt neuf Presti Presto en 1 mois.")
    }
}
