//
//  HomeRouter.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

enum HomeRouter: RouteProtocol {
case details
  
  var destination: UIViewController {
    switch self {
    case .details:
      return DetailsViewController()
    }
  }
  
  var style: RouteStyle {
    switch self {
    case .details:
      return .push
    }
  }
}
