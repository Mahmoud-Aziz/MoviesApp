//
//  FavoritesState.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 26/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

// MARK: - FavoritesState
enum FavoritesState {
  case idle
  case loading
  case reload
  case fetchingFavoriteMoviesFailed(ErrorPresentable)
  case clearAllSavedFavoritesFailed(ErrorPresentable)
  case allSavedFavoritesCleared(ErrorPresentable)
}

// MARK: - FavoritesState + Equatable
extension FavoritesState: Equatable {
  static func == (lhs: FavoritesState, rhs:FavoritesState) -> Bool {
    switch (lhs, rhs) {
    case (.idle, .idle): return true
    case (.loading, .loading): return true
    case (.reload, .reload): return true
    case (.allSavedFavoritesCleared, .allSavedFavoritesCleared): return true
    case (.fetchingFavoriteMoviesFailed, .fetchingFavoriteMoviesFailed): return true
    case (.clearAllSavedFavoritesFailed, .clearAllSavedFavoritesFailed): return true
    default:
      return false
    }
  }
}
