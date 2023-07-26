//
//  FetchFavoriteMoviesUseCase.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 26/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

// MARK: - FetchFavoriteMoviesUseCaseProtocol
protocol FetchFavoriteMoviesUseCaseProtocol {
  func execute(completion: @escaping FavoriteMovieResultClosure)
}

// MARK: - FetchFavoriteMoviesUseCase
class FetchFavoriteMoviesUseCase: FetchFavoriteMoviesUseCaseProtocol {
  private var repository: FavoritesRepositoryProtocol
  
  init(repository: FavoritesRepositoryProtocol = FavoritesRepository()) {
    self.repository = repository
  }
  
  func execute(completion: @escaping FavoriteMovieResultClosure) {
    repository.fetchFavoriteMovies(completion: completion)
  }
}
