//
//  GetSimilarMoviesUseCase.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

// MARK: - GetSimilarMoviesUseCaseProtocol
protocol GetSimilarMoviesUseCaseProtocol {
  func execute(id: Int, completion: @escaping ResultClosure<SimilarMovies>)
}

// MARK: - DetailsUseCase
class GetSimilarMoviesUseCase: GetSimilarMoviesUseCaseProtocol {
  private var repository: DetailsRepositoryProtocol
  
  init(repository: DetailsRepositoryProtocol = DetailsRepository()) {
    self.repository = repository
  }
  
  func execute(id: Int, completion: @escaping ResultClosure<SimilarMovies>) {
    repository.getSimilarMovies(id: id, completion: completion)
  }
}
