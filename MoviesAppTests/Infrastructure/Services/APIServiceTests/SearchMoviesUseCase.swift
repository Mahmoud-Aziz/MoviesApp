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
  private var debounce: Debounce?

  init(repository: HomeRepositoryProtocol = HomeRepository()) {
    self.repository = repository
  }
  
  func execute(query: String, completion: @escaping ResultClosure<PopularMovies>) {
    debounce?.invalidate()
    debounce = Debounce(delay: 0.5, completion: { [weak self] in
      self?.repository.searchMovies(query: query, completion: completion)
    })
    debounce?.resume()
  }
}
