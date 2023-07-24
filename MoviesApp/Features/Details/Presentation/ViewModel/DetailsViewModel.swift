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
  private let downloadMoviePosterUseCase: DownloadMoviePosterUseCaseProtocol
  
  // MARK: - Private Properties
  private let group: DispatchGroup
  private let movieDetails: MovieDetails
  private(set) var randomFiveSimilarMovies: [SimilarMovie]?
  private(set) var sortedTopFiveActorsCombined: [Cast]?
  private(set) var sortedTopFiveDirectorsCombined: [Crew]?
  
  // MARK: - Binding
  var posterImageDataFetched: DataClosure?
  
  // MARK: - Init
  init(group: DispatchGroup = DispatchGroup(),
       movieDetails: MovieDetails,
       getSimilarMoviesUseCase: GetSimilarMoviesUseCaseProtocol = GetSimilarMoviesUseCase(),
       getSimilarMoviesCastsUseCase: GetSimilarMoviesCastsUseCaseProtocol = GetSimilarMoviesCastsUseCase(),
       downloadMoviePosterUseCase: DownloadMoviePosterUseCaseProtocol = DownloadMoviePosterUseCase()) {
    self.group = group
    self.movieDetails = movieDetails
    self.getSimilarMoviesUseCase = getSimilarMoviesUseCase
    self.getSimilarMoviesCastsUseCase = getSimilarMoviesCastsUseCase
    self.downloadMoviePosterUseCase  = downloadMoviePosterUseCase
  }
}

// MARK: - Use Case Execution
extension DetailsViewModel {
  func getSimilarMovies(group: DispatchGroup? = nil) {
    group?.enter()
    //    state?.update(newState: .loading)
    getSimilarMoviesUseCase.execute(id: movieDetails.id) { [weak self] result in
      switch result {
      case .success(let similarMovies):
        // Extract the similar movies from the response
        let filteredSimilarMovies = similarMovies.movies.compactMap { $0 }
        // Make sure they are different every time
        let shuffledSimilarMovies = Set(filteredSimilarMovies.shuffled())
        let count = similarMovies.movies.count
        // Make sure they are within the max count range
        let randomFiveSimilarMovies = Array(shuffledSimilarMovies.prefix(min(5, count)))
        self?.randomFiveSimilarMovies = randomFiveSimilarMovies
        self?.getSimilarMoviesCasts(similarMovies: randomFiveSimilarMovies)
        
        // TODO: - [Aziz]
        //        self?.state?.update(newState: .completed)
      case .failure:
        self?.state?.update(newState: .failed(DetailsError.fetchingSimilarMoviesFailed))
      }
      group?.leave()
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
        let minActorsCount = min(5, sortedCombinedActors.count)
        let sortedTopFiveActorsCombined = Array(sortedCombinedActors.prefix(minActorsCount))
        
        self?.sortedTopFiveActorsCombined = sortedTopFiveActorsCombined
        
        // Combine all inner Crews arrays into one array
        let combinedCrews = crews.flatMap { $0 }
        // Extract only director
        let combinedDirectors = combinedCrews.filter({ $0.department == "Directing" })
        // Sort the combined array based on the 'popularity' property in descending order
        let sortedCombinedDirectors = combinedDirectors.sorted { $0.popularity > $1.popularity }
        // Ensure the final count is no more than 5
        let minDirectorsCount = min(5, sortedCombinedDirectors.count)
        let sortedTopFiveDirectorsCombined = Array(sortedCombinedDirectors.prefix(minDirectorsCount))
        
        self?.sortedTopFiveDirectorsCombined = sortedTopFiveDirectorsCombined
        
      case .failure:
        self?.state?.update(newState: .failed(DetailsError.fetchingSimilarMoviesCastsFailed))
      }
    }
  }
  
  func downloadMoviePoster(group: DispatchGroup? = nil) {
    group?.enter()
    downloadMoviePosterUseCase.execute(posterPath: movieDetails.posterPath) { [weak self] result in
      switch result {
      case .success(let imageData):
        self?.posterImageDataFetched?(imageData)
      case .failure:
        break
      }
      group?.enter()
    }
  }
}

// MARK: - View Helpers
extension DetailsViewModel {
  var movieDetailsViewData: MovieDetailsViewData {
    .init(title: movieDetails.title,
          subtitle: movieDetails.subtitle,
          voteAverage: movieDetails.formattedVoteAverage,
          overview: movieDetails.overview,
          revenue: movieDetails.formattedRevenue,
          tagline: movieDetails.tagline)
  }
  
  func performOnLoad() {
    getSimilarMovies(group: group)
    downloadMoviePoster(group: group)
  }
}
