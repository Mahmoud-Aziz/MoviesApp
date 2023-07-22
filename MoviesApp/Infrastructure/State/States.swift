//
//  States.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

// MARK: - State
public enum State {
  case idle
  case loading
  case reload
  case completed
  case failed(String)
  case navigate(RouteProtocol)
}

// MARK: - State + Equatable
extension State: Equatable {
  public static func == (lhs: State, rhs: State) -> Bool {
    switch (lhs, rhs) {
    case (.idle, .idle): return true
    case (.loading, .loading): return true
    case (.completed, .completed): return true
    case (.reload, .reload): return true
    case (.failed, .failed): return true
    case (.navigate, .navigate): return true
    default:
      return false
    }
  }
}
