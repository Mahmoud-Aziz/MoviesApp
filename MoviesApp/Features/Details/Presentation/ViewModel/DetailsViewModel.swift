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
  private(set) var randomFiveSimilarMovies: [SimilarMovie]?
  private(set) var sortedTopFiveActorsCombined: [Cast]?
  private(set) var sortedTopFiveDirectorsCombined: [Crew]?

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
extension DetailsViewModel {
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
        
        // Combine all inner Cast arrays into one array
        let combinedActors = casts.flatMap { $0 }
        // Sort the combined array based on the 'popularity' property in descending order
        let sortedCombinedActors = combinedActors.sorted { $0.popularity > $1.popularity }
        // Ensure the final count is no more than 5
        let sortedTopFiveActorsCombined = Array(sortedCombinedActors.prefix(min(5, sortedCombinedActors.count)))
        
        self?.sortedTopFiveActorsCombined = sortedTopFiveActorsCombined
        
        // Combine all inner Crews arrays into one array
        let combinedCrews = crews.flatMap { $0 }
        // Extract only director
        let combinedDirectors = combinedCrews.filter({ $0.department == "Directing" })
        // Sort the combined array based on the 'popularity' property in descending order
        let sortedCombinedDirectors = combinedDirectors.sorted { $0.popularity > $1.popularity }
        // Ensure the final count is no more than 5
        let sortedTopFiveDirectorsCombined = Array(sortedCombinedDirectors.prefix(min(5, sortedCombinedDirectors.count)))
        
        self?.sortedTopFiveDirectorsCombined = sortedTopFiveDirectorsCombined
        
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
