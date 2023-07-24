//
//  GetSimilarMoviesCastsUseCaseTests.swift
//  MoviesAppTests
//
//  Created by Mahmoud Aziz on 24/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import XCTest
@testable import MoviesApp

class GetSimilarMoviesCastsUseCaseTests: XCTestCase {
  private var mockUseCase: GetSimilarMoviesCastsUseCaseProtocol!
  private var sut: DetailsViewModel!
  
  override func setUp() {
    super.setUp()
    let cast1: [Cast] = [
      .init(name: "robert de niro", popularity: 9.0),
      .init(name: "leo de caprio", popularity: 9.1)
    ]
    
    let cast2: [Cast] = [
      .init(name: "robert de niro", popularity: 9.1),
      .init(name: "leo de caprio", popularity: 9.2)
    ]
    let cast3: [Cast] = [
      .init(name: "robert de niro", popularity: 9.2),
      .init(name: "leo de caprio", popularity: 9.3)
    ]
    let cast4: [Cast] = [
      .init(name: "robert de niro", popularity: 9.3),
      .init(name: "leo de caprio", popularity: 9.4)
    ]
    let cast5: [Cast] = [
      .init(name: "robert de niro", popularity: 9.4),
      .init(name: "leo de caprio", popularity: 9.5)
    ]
    
    let crew1: [Crew] = [
      .init(name: "martin scorsese", popularity: 9.9, department: "Directing"),
      .init(name: "martin scorsese", popularity: 9.5, department: "writing"),
    ]
    let crew2: [Crew] = [
      .init(name: "martin scorsese", popularity: 9.8, department: "Directing"),
      .init(name: "martin scorsese", popularity: 9.5, department: "writing"),
    ]
    let crew3: [Crew] = [
      .init(name: "martin scorsese", popularity: 9.6, department: "Directing"),
      .init(name: "martin scorsese", popularity: 9.5, department: "writing"),
    ]
    let crew4: [Crew] = [
      .init(name: "martin scorsese", popularity: 9.5, department: "Directing"),
      .init(name: "martin scorsese", popularity: 9.5, department: "writing"),
    ]
    let crew5: [Crew] = [
      .init(name: "martin scorsese", popularity: 9.4, department: "Directing"),
      .init(name: "martin scorsese", popularity: 9.5, department: "writing"),
    ]

    let movieCast: [MovieCast] = [
      .init(cast: cast1, crew: crew1),
      .init(cast: cast2, crew: crew2),
      .init(cast: cast3, crew: crew3),
      .init(cast: cast4, crew: crew4),
      .init(cast: cast5, crew: crew5)
    ]
    
    mockUseCase = MockGetSimilarMoviesCastsUseCase(result: .success(movieCast))
    
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
    
    sut = DetailsViewModel(movieDetails: movieDetails, getSimilarMoviesCastsUseCase: mockUseCase)
  }
  
  override func tearDown() {
    super.tearDown()
    mockUseCase = nil
    sut = nil
  }
  
  var similarMovies: [SimilarMovie] {
    [
      .init(id: 1, releaseDate: "", title: "", voteAverage: 5.5),
      .init(id: 2, releaseDate: "", title: "", voteAverage: 5.0),
      .init(id: 3, releaseDate: "", title: "", voteAverage: 6.0),
      .init(id: 4, releaseDate: "", title: "", voteAverage: 6.5),
      .init(id: 5, releaseDate: "", title: "", voteAverage: 7.0),
    ]
  }
  
  func test_TopFiveActors_areActuallyFive() {
    // When
    sut.getSimilarMoviesCasts(similarMovies: similarMovies)
    
    // Then
    XCTAssertEqual(sut.sortedTopFiveActorsCombined?.count, 5)
  }
  
  func test_TopFiveActors_areSortedDescending() {
    // When
    sut.getSimilarMoviesCasts(similarMovies: similarMovies)
    
    // Then
    XCTAssert(sut.sortedTopFiveActorsCombined!.first!.popularity > sut.sortedTopFiveActorsCombined!.last!.popularity)
  }
  
  func test_TopFiveDirectors_areActuallyFive() {
    // When
    sut.getSimilarMoviesCasts(similarMovies: similarMovies)
    
    // Then
    XCTAssertEqual(sut.sortedTopFiveDirectorsCombined?.count, 5)
  }
  
  func test_TopFiveDirectors_areSortedDescending() {
    // When
    sut.getSimilarMoviesCasts(similarMovies: similarMovies)
    
    // Then
    XCTAssert(sut.sortedTopFiveDirectorsCombined!.first!.popularity > sut.sortedTopFiveDirectorsCombined!.last!.popularity)
  }
  
  func test_TopFiveDirectors_DepartmentIsOnlyDirecting() {
    // When
    sut.getSimilarMoviesCasts(similarMovies: similarMovies)
    
    // Then
    let directors = sut.sortedTopFiveDirectorsCombined!.filter({ $0.department == "Directing" })
    XCTAssertEqual(directors.count, sut.sortedTopFiveDirectorsCombined?.count)
  }
}
