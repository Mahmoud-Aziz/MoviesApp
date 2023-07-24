//
//  DetailsError.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

enum DetailsError: ErrorPresentable {
  case fetchingSimilarMoviesFailed
  case fetchingSimilarMoviesCastsFailed
  case fetchingMoviePosterFailed
  
  var message: String {
    switch self {
    case .fetchingSimilarMoviesFailed:
      return "Sorry, we couldn't get similars for this movie :("
    case .fetchingSimilarMoviesCastsFailed:
      return "Sorry, we couldn't get similars movies casts for this movie :("
    default:
      return "Sorry, unexpected error occurred"
    }
  }
  
  var image: UIImage? {
    switch self {
    case .fetchingMoviePosterFailed:
        return .placeholder
    default:
      return .notFound
    }
  }
}
