//
//  DetailsState.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 25/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

// MARK: - DetailsState
public enum DetailsState {
  case idle
  case loadingSimilarMoviesTableView
  case loadingSimilarMoviesCastTableView
  case reloadSimilarMoviesTableView
  case reloadSimilarMoviesCastTableView
  case failedFetchingSimilarMovies(ErrorPresentable)
  case failedFetchingSimilarMoviesCasts(ErrorPresentable)
}

// MARK: - DetailsState + Equatable
extension DetailsState: Equatable {
  public static func == (lhs: DetailsState, rhs: DetailsState) -> Bool {
    switch (lhs, rhs) {
    case (.idle, .idle): return true
    case (.loadingSimilarMoviesTableView, .loadingSimilarMoviesTableView): return true
    case (.loadingSimilarMoviesCastTableView, .loadingSimilarMoviesCastTableView): return true
    case (.reloadSimilarMoviesTableView, .reloadSimilarMoviesTableView): return true
    case (.reloadSimilarMoviesCastTableView, .reloadSimilarMoviesCastTableView): return true
    case (.failedFetchingSimilarMovies, .failedFetchingSimilarMovies): return true
    case (.failedFetchingSimilarMoviesCasts, .failedFetchingSimilarMoviesCasts): return true
    default:
      return false
    }
  }
}
