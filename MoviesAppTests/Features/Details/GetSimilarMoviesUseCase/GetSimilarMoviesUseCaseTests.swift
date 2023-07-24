//
//  GetSimilarMoviesUseCaseTests.swift
//  MoviesAppTests
//
//  Created by Mahmoud Aziz on 24/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import XCTest
@testable import MoviesApp

class GetSimilarMoviesUseCaseTests: XCTestCase {
  private var mockSimilarMoviesUseCase: GetSimilarMoviesUseCaseProtocol!
  private var sut: DetailsViewModel!
  
  override func tearDown() {
    super.tearDown()
    mockSimilarMoviesUseCase = nil
    sut = nil
  }
  
  func testSimilarMovies_areRandom_CountIs5Only() {
    // Give
    let movies: [SimilarMovie] = [
      .init(id: 0, releaseDate: "", title: "", voteAverage: 5.5),
      .init(id: 0, releaseDate: "", title: "", voteAverage: 5.0),
      .init(id: 0, releaseDate: "", title: "", voteAverage: 6.0),
      .init(id: 0, releaseDate: "", title: "", voteAverage: 6.5),
      .init(id: 0, releaseDate: "", title: "", voteAverage: 7.0),
      .init(id: 0, releaseDate: "", title: "", voteAverage: 7.6),
      .init(id: 0, releaseDate: "", title: "", voteAverage: 7.8),
      .init(id: 0, releaseDate: "", title: "", voteAverage: 8.0),
      .init(id: 0, releaseDate: "", title: "", voteAverage: 8.5)
    ]
    let similarMovies = SimilarMovies(page: 1, movies: movies, totalPages: 1, totalResults: 10)
    
    // When
    mockSimilarMoviesUseCase = MockGetSimilarMoviesUseCase(result: .success(similarMovies))
    let movieDetails = MovieDetails(
      id: 1,
      overview: "",
      posterPath: "",
      releaseDate: "",
      revenue: 0,
      runtime: 0,
      status: "",
      title: "",
      voteAverage: 0.0,
      tagline: "")
    
    sut = DetailsViewModel(movieDetails: movieDetails, getSimilarMoviesUseCase: mockSimilarMoviesUseCase)
    sut.getSimilarMovies()
    
    // Then
    XCTAssertEqual(sut.randomFiveSimilarMovies?.count, 5)
    XCTAssertNotEqual(sut.randomFiveSimilarMovies?.count, 3)
  }
  
  
  func testSimilarMovies_areRandom_CountWithinSimilarMoviesRange() {
    // Give
    let movies: [SimilarMovie] = [
      .init(id: 0, releaseDate: "", title: "", voteAverage: 5.5),
      .init(id: 0, releaseDate: "", title: "", voteAverage: 5.0),
    ]
    let similarMovies = SimilarMovies(page: 1, movies: movies, totalPages: 1, totalResults: 10)
    
    // When
    mockSimilarMoviesUseCase = MockGetSimilarMoviesUseCase(result: .success(similarMovies))
    let movieDetails = MovieDetails(
      id: 1,
      overview: "",
      posterPath: "",
      releaseDate: "",
      revenue: 0,
      runtime: 0,
      status: "",
      title: "",
      voteAverage: 0.0,
      tagline: "")
    
    sut = DetailsViewModel(movieDetails: movieDetails, getSimilarMoviesUseCase: mockSimilarMoviesUseCase)
    sut.getSimilarMovies()
    
    // Then
    XCTAssertEqual(sut.randomFiveSimilarMovies?.count, 2)
    XCTAssertNotEqual(sut.randomFiveSimilarMovies?.count, 5)
  }
}
