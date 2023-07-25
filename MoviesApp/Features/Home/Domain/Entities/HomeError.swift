//
//  HomeError.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

enum HomeError: ErrorPresentable {
  case searchFailed
  case fetchingPopularMoviesFailed
  case fetchingMovieDetailsFailed

  var message: String {
    switch self {
    case .searchFailed:
      return "Search query doesn't match any of our records"
    case .fetchingPopularMoviesFailed:
      return "Sorry, unexpected error occurred! please try again"
    case .fetchingMovieDetailsFailed:
      return "Sorry, we couldn't get details for this movie"
    }
  }
  
  var image: UIImage? {
    var image: UIImage?
    switch self {
    case .searchFailed:
      image = .notFound
    case .fetchingPopularMoviesFailed:
      image = .failed
    case .fetchingMovieDetailsFailed:
      break
    }
    return image
  }
  
  var alert: UIAlertController {
    switch self {
    case .fetchingMovieDetailsFailed:
      let action = UIAlertAction(title: "dismiss", style: .default)
      let message = "Sorry, we couldn't get details for this movie"
      let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
      alert.addAction(action)
      return alert
    default:
      return .init(title: "", message: "", preferredStyle: .alert)
    }
  }
}
