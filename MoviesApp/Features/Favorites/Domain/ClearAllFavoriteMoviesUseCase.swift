//
//  ClearAllFavoriteMoviesUseCase.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 26/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

// MARK: - ClearAllFavoriteMoviesUseCaseProtocol
protocol ClearAllFavoriteMoviesUseCaseProtocol {
  func execute(completion: (Result<(), Error>) -> Void)
}

// MARK: - ClearAllFavoriteMoviesUseCase
class ClearAllFavoriteMoviesUseCase: ClearAllFavoriteMoviesUseCaseProtocol {
  private var repository: FavoritesRepositoryProtocol
  
  init(repository: FavoritesRepositoryProtocol = FavoritesRepository()) {
    self.repository = repository
  }
  
  func execute(completion: (Result<(), Error>) -> Void) {
    repository.clearAllFavoriteMovies(completion: completion)
  }
}
