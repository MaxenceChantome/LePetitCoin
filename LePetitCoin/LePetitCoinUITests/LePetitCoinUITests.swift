//
//  LePetitCoinUITests.swift
//  LePetitCoinUITests
//
//  Created by Maxence Chantôme on 24/06/2021.
//

import XCTest

class LePetitCoinUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }
    
    /// Test if list controller is presented and  tableView is filled with correct data
    func testListController() {
        app.launch()
        let tableView = app.tables["listTableView"]
        XCTAssertEqual(tableView.exists, true)
        
        let cell = tableView.cells.element(matching: .cell, identifier: "listCell_2")
        XCTAssertEqual(cell.waitForExistence(timeout: 5), true)
        XCTAssertEqual(cell.staticTexts["nameLabel"].label, "Bouillotte Dodie")
        XCTAssertEqual(cell.staticTexts["priceLabel"].label, "5 €")
        XCTAssertEqual(cell.staticTexts["dateLabel"].label, "Le 05/11 à 16:55")
        XCTAssertEqual(cell.staticTexts["categoryLabel"].label, "Enfants")
        XCTAssertEqual(cell.staticTexts["urgentLabel"].label, "Urgent")
    }
    
    /// Test if list controller shows and if the dismiss button works well
    func testShowAndDismissFilterController() {
        app.launch()
        app.buttons["filterButton"].tap()
        let tableView = app.tables["filterTableView"]
        XCTAssertEqual(tableView.exists, true)
        
        app.buttons["dismissButton"].firstMatch.tap()
        
        XCTAssertEqual(tableView.exists, false)
    }
    
    /// Test if filter controller shows valid data and filter the list controller
    func testFilterController() {
        app.launch()
        /// Wait for list to load before testing in order to test previous / after filter
        let listCell = app.tables["listTableView"].cells.element(matching: .cell, identifier: "listCell_0")
        XCTAssertEqual(listCell.waitForExistence(timeout: 5), true)
        XCTAssertEqual(listCell.staticTexts["categoryLabel"].label, "Mode")
        
        /// Show filter controller
        app.buttons["filterButton"].tap()
        let tableView = app.tables["filterTableView"]
        XCTAssertEqual(tableView.exists, true)
        
        /// Select cell and tap on button to confirm fiilter
        let cell = tableView.cells.element(matching: .cell, identifier: "categoryCell_10")
        XCTAssertEqual(cell.staticTexts["categoryLabel"].label, "Enfants")
        cell.tap()
        app.buttons["dockedButton"].firstMatch.tap()
        XCTAssertEqual(tableView.exists, false)
        
        /// listCell category should be "Enfants", before filtering the list it was "Mode"
        XCTAssertEqual(listCell.staticTexts["categoryLabel"].label, "Enfants")
    }
    

    /// Test if list controller is presented and  tableView is filled with correct data
    func testAdController() {
        app.launch()
        /// Click on ad to show ad controller
        let listCell = app.tables["listTableView"].cells.element(matching: .cell, identifier: "listCell_1")
        XCTAssertEqual(listCell.waitForExistence(timeout: 5), true)
        listCell.tap()

        /// Test if ads data are valid
        let tableView = app.tables["adTableView"]
        XCTAssertEqual(tableView.exists, true)
        XCTAssertEqual(tableView.staticTexts["adUrgentLabel"].label, "Urgent")
        XCTAssertEqual(tableView.staticTexts["categoryLabel"].label, "Multimédia")
        XCTAssertEqual(tableView.staticTexts["nameLabel"].label, "Sony Ericsson Xperia Arc S + coque (occasion)")
        XCTAssertEqual(tableView.staticTexts["priceLabel"].label, "50 €")
        XCTAssertEqual(tableView.staticTexts["dateLabel"].label, "Posté le 05/11 à 16:56")
        XCTAssertEqual(tableView.staticTexts["descriptionLabel"].label, "Je vends ce Sony Ericsson Xperia Arc S, TOUT fonctionne PARFAITEMENT.  Le téléphone présente quelques traces d'usures (rayures). Un téléphone comme celui-ci vaut actuellement 80 Euro(s) sur internet, je vous le vends donc pour 50 Euro(s) avec la coque en cadeau !  Modèle : LT18i")
    }
}
