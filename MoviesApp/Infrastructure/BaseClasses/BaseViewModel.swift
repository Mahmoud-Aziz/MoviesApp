//
//  BaseViewModel.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

// MARK: - StatableViewModel
public protocol StatableViewModel {
  var state: Stateful? { get set }
}

// MARK: - BaseViewModel + StatableViewModel
class BaseViewModel: StatableViewModel {
  private var stateful: Stateful?
  
  var state: Stateful? {
    get {
      stateful
    } set {
      stateful = newValue
    }
  }
}
