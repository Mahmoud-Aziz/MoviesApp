//
//  APIServiceTests.swift
//  MoviesAppTests
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.

import Foundation
@testable import MoviesApp
import XCTest

struct ResponseModelForTest: Decodable {
  let name: String
  let employees: Int
}

class APIServiceTests: XCTestCase {
  var apiService: APIServiceProtocol!
  var baseURL: URL {
    URL(string: "https://api.themoviedb.org/3/search/movie")!
  }
  
  override func setUp() {
    let configuration = URLSessionConfiguration.default
    configuration.protocolClasses = [MockURLProtocol.self]
    let mockedSession = URLSession(configuration: configuration)
    apiService = APIService(session: mockedSession)
  }
  
  override func tearDown() {
    super.tearDown()
    apiService = nil
  }
  
  func testSendRequest_SuccessfulResponse() {
    // Given
    let expectation = self.expectation(description: "Expecting successful response")
    let sampleData = """
        {
            "name": "Telda",
            "employees": 100
        }
        """.data(using: .utf8)!
    
    MockURLProtocol.requestHandler = { request in
      guard let url = request.url, url == self.baseURL else {
        throw APIError.failedRequest
      }
      let response = HTTPURLResponse(url: self.baseURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
      return (response, sampleData)
    }
    // When
    apiService.sendRequest(decodable: ResponseModelForTest.self, request: createSampleRequest()) { result in
      // Then
      switch result {
      case let .success(response):
        XCTAssertEqual(response.name, "Telda")
        XCTAssertEqual(response.employees, 100)
        expectation.fulfill()
        
      case let .failure(error):
        XCTFail("Unexpected error: \(error)")
      }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testSendRequest_FailureResponse() {
    // Given
    let expectation = self.expectation(description: "Expecting failure response")
    let sampleData = """
        {
            "company": Telda,
            "employees": 100
        }
        """.data(using: .utf8)!
    
    MockURLProtocol.requestHandler = { request in
      guard let url = request.url, url == self.baseURL else {
        throw APIError.failedRequest
      }
      let response = HTTPURLResponse(url: self.baseURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
      return (response, sampleData)
    }
    
    // When
    apiService.sendRequest(decodable: ResponseModelForTest.self, request: createSampleRequest()) { result in
      // Then
      switch result {
      case let .success(response):
        XCTFail("Unexpected success response: \(response)")
        
      case let .failure(error):
        XCTAssert(error == APIError.mappingError)
        expectation.fulfill()
      }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testSendRequest_SuccessfulResponse_EmptyData() {
    // Given
    let expectation = self.expectation(description: "Expecting successful response with empty data")
    
    MockURLProtocol.requestHandler = { request in
      guard let url = request.url, url == self.baseURL else {
        throw APIError.failedRequest
      }
      let response = HTTPURLResponse(url: self.baseURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
      return (response, Data())
    }
    
    // When
    apiService.sendRequest(decodable: ResponseModelForTest.self, request: createSampleRequest()) { result in
      // Then
      switch result {
      case .success:
        XCTFail("Unexpected, should fail with mapping error")
      case let .failure(error):
        XCTAssertTrue(error == .mappingError)
        expectation.fulfill()
      }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testSendRequest_NetworkError() {
    // Given
    let expectation = self.expectation(description: "Expecting network error")
    
    MockURLProtocol.requestHandler = { _ in
      throw APIError.failedRequest
    }
    
    // When
    apiService.sendRequest(decodable: ResponseModelForTest.self, request: createSampleRequest()) { result in
      // Then
      switch result {
      case let .success(response):
        XCTFail("Unexpected success response: \(response)")
        
      case let .failure(error):
        XCTAssert(error == APIError.failedRequest)
        expectation.fulfill()
      }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testSendRequest_FailureResponse_InvalidJSON() {
    // Given
    let expectation = self.expectation(description: "Expecting failure response with invalid JSON")
    let invalidData = """
          {
              "name": "Telda"
              "employees": 100
          }
          """.data(using: .utf8)!
    
    MockURLProtocol.requestHandler = { request in
      guard let url = request.url, url == self.baseURL else {
        throw APIError.failedRequest
      }
      let response = HTTPURLResponse(url: self.baseURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
      return (response, invalidData)
    }
    
    // When
    apiService.sendRequest(decodable: ResponseModelForTest.self, request: createSampleRequest()) { result in
      // Then
      switch result {
      case let .success(response):
        XCTFail("Unexpected success response: \(response)")
        
      case let .failure(error):
        XCTAssert(error == APIError.mappingError)
        expectation.fulfill()
      }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testSendRequest_FailureResponse_InvalidDataType() {
    // Given
    let expectation = self.expectation(description: "Expecting failure response with invalid data type")
    let invalidData = """
          {
              "name": 123,
              "employees": "100"
          }
          """.data(using: .utf8)!
    
    MockURLProtocol.requestHandler = { request in
      guard let url = request.url, url == self.baseURL else {
        throw APIError.failedRequest
      }
      let response = HTTPURLResponse(url: self.baseURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
      return (response, invalidData)
    }
    
    // When
    apiService.sendRequest(decodable: ResponseModelForTest.self, request: createSampleRequest()) { result in
      // Then
      switch result {
      case let .success(response):
        XCTFail("Unexpected success response: \(response)")
        
      case let .failure(error):
        XCTAssert(error == APIError.mappingError)
        expectation.fulfill()
      }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  // Helper method to create a sample URLRequest for testing
  private func createSampleRequest() -> URLRequest {
    var request = URLRequest(url: baseURL)
    request.httpMethod = "GET"
    
    return request
  }
}
