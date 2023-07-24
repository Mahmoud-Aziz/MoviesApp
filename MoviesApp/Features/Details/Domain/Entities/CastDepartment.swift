//
//  CastDepartment.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 25/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

enum CastDepartment: CaseIterable {
  case acting
  case directing
  
  var headerTitle: String {
    switch self {
    case .acting:
      return "Similar movies actors"
    case .directing:
      return "Similar Movies Directors"
    }
  }
}
