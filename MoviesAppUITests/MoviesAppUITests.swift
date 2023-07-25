//
//  MoviesAppUITests.swift
//  MoviesAppUITests
//
//  Created by Mahmoud Aziz on 25/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import XCTest
@testable import MoviesApp

final class MoviesAppUITests: XCTestCase {
  func testNavigationBarExists() {
    let app = XCUIApplication()
    app.launch()
    let navigationBar = app.navigationBars.element(boundBy: 0)
    XCTAssert(navigationBar.exists)
  }
  
  func testSearchBarExists() {
    let app = XCUIApplication()
    app.launch()
    let searchBar = app.searchFields.element(boundBy: 0)
    XCTAssertTrue(searchBar.exists)
    XCTAssertEqual(searchBar.placeholderValue, "Search Movies")
  }
  
  func testTableViewExists() {
    let app = XCUIApplication()
    app.launch()
    let tableView = app.tables["HomeTableView"]
    XCTAssertTrue(tableView.exists)
  }
  
  func testNavigationBarTitle() {
    let app = XCUIApplication()
    app.launch()
    let viewControllerTitle = app.navigationBars.staticTexts["TMDB Discovery"].label
    XCTAssertEqual(viewControllerTitle, "TMDB Discovery", "View controller has an incorrect title.")
  }
  
  func testSearchBarPlaceholder() {
    let app = XCUIApplication()
    app.launch()
    let searchBar = app.searchFields.element(boundBy: 0)
    XCTAssertTrue(searchBar.exists)
    XCTAssertEqual(searchBar.placeholderValue, "Search Movies")
  }
  
  func testNavigationToDetailsAndBack() {
    let app = XCUIApplication()
    app.launch()
    let tableView = app.tables["HomeTableView"]
    let cell = tableView.cells.element(boundBy: 0)
    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
      cell.tap()
      let homeViewController = app.otherElements["HomeViewController"]
      let nextViewController = app.otherElements["DetailsViewController"]
      XCTAssertTrue(nextViewController.waitForExistence(timeout: 5), "Details did not appear")
      let backButton = app.navigationBars.buttons["DetailsBackButton"]
      XCTAssertTrue(backButton.exists, "Back button does not have the expected accessibility identifier.")
      XCTAssertTrue(nextViewController.exists, "Next view controller is not on the navigation stack.")
      backButton.tap()
      XCTAssertTrue(homeViewController.waitForExistence(timeout: 1), "Details did not appear")
      XCTAssertTrue(homeViewController.exists, "Error back to home.")
    })
  }
}
