//
//  MoviesSearchUseCaseTests.swift
//  MoviesAppTests
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.

import Foundation
import XCTest
@testable import MoviesApp

class MoviesSearchUseCaseTests: XCTestCase {
  
  var sut: HomeViewModel!
  var mockUseCase: MockMoviesSearchUseCase!
  var debounce: Debounce?
  
  override func setUp() {
    super.setUp()
    mockUseCase = MockMoviesSearchUseCase()
    sut = HomeViewModel(searchMoviesUseCase: mockUseCase)
    
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
    mockUseCase = nil
  }
  
  func testSearchMovies_Successful() {
    // Given
    let query = "Avengers"
    let movies: [Movie] = [
      .init(id: 1, title: "The Avengers", releaseDate: "2012-05-04", voteAverage: 7.0),
      .init(id: 2, title: "Avengers: Age of Ultron", releaseDate: "2015-05-01", voteAverage: 7.6),
      .init(id: 3, title: "Avengers: Endgame", releaseDate: "2019-04-26", voteAverage: 9.0)
      ]
    let popularMovies = PopularMovies(currentPage: 1, movies: movies, totalPages: 1, totalResults: 100)
    mockUseCase.result = .success(popularMovies)
    
    // When
    sut.search(query: query)
    
    // Then
    XCTAssertEqual(sut.searchFilteredResults!.count, 3)
    XCTAssertEqual(sut.totalPages, 1)
  }
  
  func testSearchMovies_Failure() {
    // Given
    let query = "Non-existing-movie"
    let searchExpectation = expectation(description: "search expectation")

    mockUseCase.result = .failure(.failedRequest)
    
    // When
    sut.performOnLoad()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
      self?.sut.search(query: query)
      searchExpectation.fulfill()
    }
    
    wait(for: [searchExpectation], timeout: 5.0)
    
    // Then
    XCTAssertEqual(sut.searchFilteredResults!.count, sut.movies!.count)
  }
  
  func testDebounce_SearchMovies() {
    // Given
    let debounceExpectation = expectation(description: "Debounce expectation")
    
    // When
    debounce?.invalidate()
    debounce = Debounce(delay: 0.4, completion: { [weak self] in
      let query = "Spider-Man"
      self?.mockUseCase.lastQuery = query
      self?.mockUseCase.executeCallCount += 1
      self?.sut.search(query: query)
      // then
      XCTAssertEqual(self?.mockUseCase.executeCallCount, 1)
    })
    
    debounce?.resume()
    
    debounce = Debounce(delay: 0.7, completion: { [weak self] in
      let query = "Iron Man"
      self?.mockUseCase.lastQuery = query
      self?.mockUseCase.executeCallCount += 1
      self?.sut.search(query: "Iron Man")
      // then
      XCTAssertEqual(self?.mockUseCase.executeCallCount, 2)
      XCTAssertEqual(self?.mockUseCase.lastQuery, "Iron Man")
      debounceExpectation.fulfill()
    })
    
    debounce?.resume()
    waitForExpectations(timeout: 1, handler: nil)
  }
}
