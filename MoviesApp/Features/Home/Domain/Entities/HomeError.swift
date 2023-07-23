//
//  HomeError.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

public protocol ErrorPresentable {
  var message: String { get }
  var image: UIImage? { get }
}

enum HomeError: ErrorPresentable {
  case searchFailed
  case fetchingPopularMoviesFailed
  
  var message: String {
    switch self {
    case .searchFailed:
      return "Sorry, unexpected error occurred! please try again"
    case .fetchingPopularMoviesFailed:
      return "Search query doesn't match any of our records, please try again with a different one"
    }
  }
  
  var image: UIImage? {
    switch self {
    case .searchFailed:
      return .notFound
    case .fetchingPopularMoviesFailed:
      return .failed
    }
  }
}
