//
//  HomeState.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 25/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

// MARK: - HomeState
enum HomeState {
  case idle
  case loading
  case reload
  case failed(ErrorPresentable)
  case fetchingMovieDetailsFailed(ErrorPresentable)
  case navigate(RouteProtocol)
}

// MARK: - HomeState + Equatable
extension HomeState: Equatable {
  static func == (lhs: HomeState, rhs: HomeState) -> Bool {
    switch (lhs, rhs) {
    case (.idle, .idle): return true
    case (.loading, .loading): return true
    case (.reload, .reload): return true
    case (.failed, .failed): return true
    case (.fetchingMovieDetailsFailed, .fetchingMovieDetailsFailed): return true
    case (.navigate, .navigate): return true
    default:
      return false
    }
  }
}
