//
//  GetPopularMoviesUseCase.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

// MARK: - GetPopularMoviesUseCaseProtocol
protocol GetPopularMoviesUseCaseProtocol {
  func execute(pageCount: Int, completion: @escaping ResultClosure<PopularMovies>)
}

// MARK: - GetPopularMoviesUseCase
class GetPopularMoviesUseCase: GetPopularMoviesUseCaseProtocol {
  private var repository: HomeRepositoryProtocol
  
  init(repository: HomeRepositoryProtocol = HomeRepository()) {
    self.repository = repository
  }
  
  func execute(pageCount: Int, completion: @escaping ResultClosure<PopularMovies>) {
    repository.getPopularMovies(pageCount: pageCount, completion: completion)
  }
}
