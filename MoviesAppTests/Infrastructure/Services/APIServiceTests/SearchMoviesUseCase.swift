//
//  SearchMoviesUseCase.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

// MARK: - SearchMoviesUseCaseProtocol
protocol SearchMoviesUseCaseProtocol {
  func execute(query: String, completion: @escaping ResultClosure<PopularMovies>)
}

// MARK: - SearchMoviesUseCase
class SearchMoviesUseCase: SearchMoviesUseCaseProtocol {
  private var repository: HomeRepositoryProtocol
  
  init(repository: HomeRepositoryProtocol = HomeRepository()) {
    self.repository = repository
  }
  
  func execute(query: String, completion: @escaping ResultClosure<PopularMovies>) {
    repository.searchMovies(query: query, completion: completion)
  }
}
