//
//  MovieDBCodingChallengeUITests.swift
//  MovieDBCodingChallengeUITests
//
//  Created by Wojciech Kudrynski on 12/01/2024.
//

import XCTest

final class MovieDBCodingChallengeUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        app.terminate()
        app = nil
        
        try super.tearDownWithError()
    }

    func test_mainScreen_tableView_loadedProperly() throws {
        let tableView = app.tables["mainScreen_tableView"]
        XCTAssertTrue(tableView.exists)
        XCTAssert(tableView.cells.count > 0)
    }
    
    func test_mainScreen_searchBar_workingAsExpected() throws {
        let tableViewCell = app.tables["mainScreen_tableView"].cells.firstMatch
        let cellTitleLabel = tableViewCell.staticTexts["movieCell_title"]
        XCTAssertTrue(cellTitleLabel.exists)
        let oldFirstTitle = cellTitleLabel.label
        
        let searchBar = app.otherElements["mainScreen_searchBar"]
        XCTAssertTrue(searchBar.exists)
        let searchTextField = searchBar.searchFields["mainScreen_searchBar_searchTextField"]
        searchTextField.tap()
        searchTextField.typeText("google")
        XCTAssertNotEqual(oldFirstTitle, cellTitleLabel.label)
        searchBar.buttons["Clear text"].tap()
        XCTAssertEqual(oldFirstTitle, cellTitleLabel.label)
    }
    
    func test_mainScreen_addToFavouritesButton_switchProperly() throws {
        let tableViewCell = app.tables["mainScreen_tableView"].cells.firstMatch
        let addToFavouritesButton = tableViewCell.buttons["movieCell_addToFavourites"].firstMatch
        let savedImage = addToFavouritesButton.images.firstMatch
        
        XCTAssertTrue(addToFavouritesButton.exists)
        addToFavouritesButton.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        let newImage = addToFavouritesButton.images.firstMatch
        XCTAssertNotEqual(savedImage, newImage)
        addToFavouritesButton.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        XCTAssertNotEqual(newImage, addToFavouritesButton.images.firstMatch)
    }
    
    func test_mainScreen_cellTapeed_detailsScreenShowedProperly() throws {
        let tableViewCell = app.tables["mainScreen_tableView"].cells.firstMatch
        tableViewCell.tap()
        let detailsView = app.scrollViews["detailsScreen_scrollView"]
        XCTAssertTrue(detailsView.exists)
    }
    
    func test_detailsScreen_addToFavouritesButton_switchProperly() throws {
        let tableViewCell = app.tables["mainScreen_tableView"].cells.firstMatch
        tableViewCell.tap()
        let navBar = app.navigationBars["navBar"]
        XCTAssertTrue(navBar.exists)
        let addToFavouritesButton = navBar.buttons["detailsScreen_addToFavourites"].firstMatch
        let savedImage = addToFavouritesButton.images.firstMatch
        
        XCTAssertTrue(addToFavouritesButton.exists)
        addToFavouritesButton.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        let newImage = addToFavouritesButton.images.firstMatch
        XCTAssertNotEqual(savedImage, newImage)
        addToFavouritesButton.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        XCTAssertNotEqual(newImage, addToFavouritesButton.images.firstMatch)
    }
}
