//
//  HomeRouter.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

enum HomeRouter: RouteProtocol {
  case details(MovieDetails)
  case favorites

  var destination: UIViewController {
    switch self {
    case let .details(movieDetails):
      let viewModel = DetailsViewModel(movieDetails: movieDetails)
      return DetailsViewController(viewModel: viewModel)
    case .favorites:
      return FavoritesViewController()
    }
  }
  
  var style: RouteStyle {
    switch self {
    case .details:
      return .push
    case .favorites:
      return .present
    }
  }
}
