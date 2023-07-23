//
//  GetSimilarMoviesCastsUseCase.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

// MARK: - GetSimilarMoviesCastsUseCaseProtocol
protocol GetSimilarMoviesCastsUseCaseProtocol {
  func execute(similarMovies: [SimilarMovie], completion: @escaping ResultClosure<[MovieCast]>)
}

// MARK: - DetailsUseCase
class GetSimilarMoviesCastsUseCase: GetSimilarMoviesCastsUseCaseProtocol {
  private var repository: DetailsRepositoryProtocol
  private var group: DispatchGroup
  
  init(repository: DetailsRepositoryProtocol = DetailsRepository(), group: DispatchGroup = DispatchGroup()) {
    self.repository = repository
    self.group = group
  }
  
  func execute(similarMovies: [SimilarMovie], completion: @escaping ResultClosure<[MovieCast]>) {
    var similarMoviesCasts: [MovieCast]? = []
    let similarMoviesIDs = similarMovies.compactMap({ $0.id })
    for movieID in similarMoviesIDs {
      group.enter()
      repository.getMovieCast(id: movieID) { [weak self] result in
        switch result {
        case .success(let cast):
          similarMoviesCasts?.append(cast)
        case .failure:
          break
        }
        self?.group.leave()
      }
    }
    
    group.notify(queue: .main) {
      guard let similarMoviesCasts, !similarMoviesCasts.isEmpty else {
        completion(.failure(.failedRequest))
        return
      }
      completion(.success(similarMoviesCasts))
    }
  }
}
