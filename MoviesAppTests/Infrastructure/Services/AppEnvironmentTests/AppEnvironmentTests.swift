//
//  AppEnvironmentTests.swift
//  MoviesAppTests
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.

@testable import MoviesApp
import XCTest

class AppEnvironmentTests: XCTestCase {
  var appEnvironment: AppEnvironmentProtocol!
  
  override func setUp() {
    super.setUp()
    appEnvironment = ServiceLocator.shared.environment
  }
  
  override func tearDown() {
    appEnvironment = nil
    super.tearDown()
  }
  
  func testBundleID() {
    XCTAssertNoThrow(appEnvironment.bundleID, "Fetching bundleID should not throw any errors")
  }
  
  func testAppName() {
    let appName = appEnvironment.appName
    XCTAssertFalse(appName.isEmpty, "App name should not be empty")
  }
  
  func testBaseURL() {
    let baseURL = appEnvironment.baseURL
    XCTAssertFalse(baseURL.isEmpty, "Base URL should not be empty")
  }
  
  func testApiKey() {
    let apiKey = appEnvironment.apiKey
    XCTAssertFalse(apiKey.isEmpty, "API key should not be empty")
  }
  
  // Test for each key in EnvironmentKey enum to ensure correct values are fetched from Info.plist
  func testFetchString() {
    let appName = appEnvironment.string(key: .appName)
    XCTAssertFalse(appName.isEmpty, "Fetched string should not be empty")
  }
  
  // Test for a missing key in Info.plist
  func testMissingKey() {
    // Provide a non-existent key to test
    XCTAssertThrowsError(try appEnvironment.fetch(key: "NonExistentKey"),
                         "Fetching a missing key should throw an error")
    { error in
      XCTAssert(error is AppEnvironmentError)
      XCTAssertEqual(error as? AppEnvironmentError, .keyNotFound(key: "NonExistentKey"))
    }
  }
}
