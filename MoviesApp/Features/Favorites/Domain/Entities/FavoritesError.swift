//
//  FavoritesError.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 26/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

enum FavoritesError: ErrorPresentable {
  case fetchingFavoriteMoviesFailed
  case clearAllSavedFavoritesFailed
  case allSavedFavoritesCleared
  
  var message: String {
    switch self {
    case .fetchingFavoriteMoviesFailed:
      return "Search query doesn't match any of our records"
    case .clearAllSavedFavoritesFailed:
      return "Sorry, unexpected error occurred! please try again"
    case .allSavedFavoritesCleared:
      return "All saved favorites are cleared!"
    }
  }
  
  var image: UIImage? {
    var image: UIImage?
    switch self {
    case .fetchingFavoriteMoviesFailed:
      image = .failed
    default:
      break
    }
    return image
  }
  
  var alert: UIAlertController {
    switch self {
    case .clearAllSavedFavoritesFailed:
      let action = UIAlertAction(title: "dismiss", style: .default)
      let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
      alert.addAction(action)
      return alert
    case .allSavedFavoritesCleared:
      let action = UIAlertAction(title: "dismiss", style: .default)
      let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
      alert.addAction(action)
      return alert
    default:
      return .init(title: "", message: "", preferredStyle: .alert)
    }
  }
}
