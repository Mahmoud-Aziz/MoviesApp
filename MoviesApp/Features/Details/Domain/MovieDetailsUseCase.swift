//
//  MovieDetailsUseCase.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

typealias MovieDetailsResultClosure = (MovieDetails?, PopularMovies?, MovieCast?) -> Void

// MARK: - DetailsUseCaseProtocol
protocol MovieDetailsUseCaseProtocol {
  func execute(id: Int, completion: @escaping MovieDetailsResultClosure)
}

// MARK: - DetailsUseCase
class MovieDetailsUseCase: MovieDetailsUseCaseProtocol {
  private var repository: MovieDetailsRepositoryProtocol
  private var movieDetails: MovieDetails?
  private var similarMovies: PopularMovies?
  private var movieCast: MovieCast?
  private let dispatchGroup: DispatchGroup
  
  init(repository: MovieDetailsRepositoryProtocol = MovieDetailsRepository(),
       dispatchGroup: DispatchGroup = DispatchGroup()) {
    self.repository = repository
    self.dispatchGroup = dispatchGroup
  }
  
  func execute(id: Int, completion: @escaping MovieDetailsResultClosure) {
    getMovieDetails(id: id)
    getSimilarMovies(id: id)
    
    dispatchGroup.notify(queue: .main) { [weak self] in
      completion(self?.movieDetails, self?.similarMovies, self?.movieCast)
    }
  }
}

// MARK: - DispatchGroup Elements
private extension MovieDetailsUseCase {
  func getMovieDetails(id: Int) {
    dispatchGroup.enter()
    repository.getMovieDetails(id: id) { [weak self] result in
      switch result {
      case .success(let response):
        self?.movieDetails = response
      case .failure(let error):
        break
      }
      self?.dispatchGroup.leave()
    }
  }
  
  func getSimilarMovies(id: Int) {
    dispatchGroup.enter()
    repository.getSimilarMovies(id: id) { [weak self] result in
      switch result {
      case .success(let response):
        self?.similarMovies = response
        guard let similarMovies = self?.similarMovies else { return }
        self?.getCasts(similarMovies: similarMovies.movies)
      case .failure(let error):
        break
      }
      self?.dispatchGroup.leave()
    }
  }
  
  func getCasts(similarMovies: [Movie]) {
    let similarMoviesIDs = similarMovies.compactMap({ $0.id })
    for movieID in similarMoviesIDs {
      dispatchGroup.enter()
      repository.getMovieCast(id: movieID) { [weak self] result in
        switch result {
        case .success(let response):
          self?.movieCast = response
        case .failure(let error):
          break
        }
        self?.dispatchGroup.leave()
      }
    }
  }
}
