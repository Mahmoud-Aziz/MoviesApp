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
}
