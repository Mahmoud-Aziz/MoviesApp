//
//  FavoritesViewModel.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 26/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

class FavoritesViewModel {
  // MARK: - Use Cases
  private var fetchFavoriteMoviesUseCase: FetchFavoriteMoviesUseCaseProtocol
  private var clearAllFavoriteMoviesUseCase: ClearAllFavoriteMoviesUseCaseProtocol
  
  // MARK: - Private Properties
  private var favoriteMovies: [FavoriteMovie]?
  
  // MARK: - Binding
  var state: FavoritesStateClosure?
  
  // MARK: - Init
  init(fetchFavoriteMoviesUseCase: FetchFavoriteMoviesUseCaseProtocol = FetchFavoriteMoviesUseCase(),
       clearAllFavoriteMoviesUseCase: ClearAllFavoriteMoviesUseCaseProtocol = ClearAllFavoriteMoviesUseCase()) {
    self.fetchFavoriteMoviesUseCase = fetchFavoriteMoviesUseCase
    self.clearAllFavoriteMoviesUseCase = clearAllFavoriteMoviesUseCase
  }
}

// MARK: - Use Case Execution
extension FavoritesViewModel {
  func fetchFavoriteMovie() {
    state?(.loading)
    fetchFavoriteMoviesUseCase.execute { [weak self] result in
      switch result {
      case .success(let favoriteMovies):
        self?.favoriteMovies = favoriteMovies
        self?.state?(.reload)
      case .failure:
        self?.state?(.fetchingFavoriteMoviesFailed(FavoritesError.fetchingFavoriteMoviesFailed))
      }
    }
    state?(.reload)
  }
  
  func clearAllFavoriteMovies() {
    clearAllFavoriteMoviesUseCase.execute { [weak self] result in
      switch result {
      case .success:
        self?.state?(.allSavedFavoritesCleared(FavoritesError.allSavedFavoritesCleared))
        self?.fetchFavoriteMovie()
      case .failure:
        self?.state?(.clearAllSavedFavoritesFailed(FavoritesError.clearAllSavedFavoritesFailed))
      }
    }
  }
}

// MARK: - View Helpers
extension FavoritesViewModel {
  var itemsCount: Int {
    favoriteMovies?.count ?? .zero
  }
  
  func getItem(at index: IndexPath) -> FavoriteMovie? {
    guard let favoriteMovies, !favoriteMovies.isEmpty else { return nil }
    return favoriteMovies[index.row]
  }
}
