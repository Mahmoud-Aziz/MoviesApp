//
//  DetailsViewModel.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

class DetailsViewModel: BaseViewModel {
  // MARK: - Use Cases
  private let getSimilarMoviesUseCase: GetSimilarMoviesUseCaseProtocol
  private let getSimilarMoviesCastsUseCase: GetSimilarMoviesCastsUseCaseProtocol
  
  // MARK: - Private Properties
  private let movieDetails: MovieDetails
  private var randomFiveSimilarMovies: [SimilarMovie]?
  private var sortedTopFiveCasts: [[Cast]]?
  private var sortedTopFiveCrews: [[Crew]]?

  // MARK: - Init
  init(movieDetails: MovieDetails,
       getSimilarMoviesUseCase: GetSimilarMoviesUseCaseProtocol = GetSimilarMoviesUseCase(),
       getSimilarMoviesCastsUseCase: GetSimilarMoviesCastsUseCaseProtocol = GetSimilarMoviesCastsUseCase()) {
    self.movieDetails = movieDetails
    self.getSimilarMoviesUseCase = getSimilarMoviesUseCase
    self.getSimilarMoviesCastsUseCase = getSimilarMoviesCastsUseCase
  }
}

// MARK: - Use Case Execution
private extension DetailsViewModel {
  func getSimilarMovies() {
    //    state?.update(newState: .loading)
    getSimilarMoviesUseCase.execute(id: movieDetails.id) { [weak self] result in
      switch result {
      case .success(let similarMovies):
        let filteredSimilarMovies = similarMovies.movies.compactMap { $0 }
        let shuffledSimilarMovies = Set(filteredSimilarMovies.shuffled())
        let count = similarMovies.movies.count
        let randomFiveSimilarMovies = Array(shuffledSimilarMovies.prefix(min(5, count)))
        self?.randomFiveSimilarMovies = randomFiveSimilarMovies
        self?.getSimilarMoviesCasts(similarMovies: randomFiveSimilarMovies)
        //        self?.state?.update(newState: .completed)
      case .failure:
        self?.state?.update(newState: .failed(DetailsError.fetchingSimilarMoviesFailed))
      }
    }
  }
  
  func getSimilarMoviesCasts(similarMovies: [SimilarMovie]) {
    getSimilarMoviesCastsUseCase.execute(similarMovies: similarMovies) { [weak self] result in
      switch result {
      case .success(let similarMoviesCasts):
        // Get the inner arrays of Cast
        let casts = similarMoviesCasts.compactMap({ $0.cast })
        // Get the inner arrays of Crews
        let crews = similarMoviesCasts.compactMap({ $0.crew })
        
        var sortedTopFiveCasts: [[Cast]] = []
        for cast in casts {
          // Sort each Cast array individually
          let sortedCast = cast.sorted(by: { $0.popularity > $1.popularity })
          // Append only first 5 elements and make sure to stay within count range
          sortedTopFiveCasts.append(Array(sortedCast.prefix(min(5, sortedCast.count))))
        }
        self?.sortedTopFiveCasts = sortedTopFiveCasts
        
        var sortedTopFiveCrews: [[Crew]] = []
        for crew in crews {
          // Sort each Crew array individually
          let sortedCrew = crew.sorted(by: { $0.popularity > $1.popularity })
          // Append only first 5 elements and make sure to stay within count range
          sortedTopFiveCrews.append(Array(sortedCrew.prefix(min(5, sortedCrew.count))))
        }
        self?.sortedTopFiveCrews = sortedTopFiveCrews
        
      case .failure:
        self?.state?.update(newState: .failed(DetailsError.fetchingSimilarMoviesCastsFailed))
      }
    }
  }
}

// MARK: - View Helpers
extension DetailsViewModel {
  func performOnLoad() {
    getSimilarMovies()
  }
}
