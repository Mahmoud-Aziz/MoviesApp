//
//  MoviesAppUITests.swift
//  MoviesAppUITests
//
//  Created by Mahmoud Aziz on 25/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import XCTest

final class MoviesAppUITests: XCTestCase {
  
  func testExample() throws {

  }
  
  func testSearchBarExists() {
    let app = XCUIApplication()
    app.launch()
    let searchField = app.windows.children(matching: .searchField)
    XCTAssertTrue(searchField.element.exists)
  }
  
  func testLaunchPerformance() throws {
    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
      measure(metrics: [XCTApplicationLaunchMetric()]) {
        XCUIApplication().launch()
      }
    }
  }
}
