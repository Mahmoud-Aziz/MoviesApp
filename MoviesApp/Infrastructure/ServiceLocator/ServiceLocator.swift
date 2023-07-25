//
//  ServiceLocator.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

// MARK: - ServiceLocatorProtocol
protocol ServiceLocatorProtocol {
  var environment: AppEnvironmentProtocol { get }
  var apiService: APIServiceProtocol { get }
}

// MARK: - ServiceLocator
final class ServiceLocator: ServiceLocatorProtocol {
  // MARK: - Internal Properties
  static let shared = ServiceLocator()
  
  // MARK: - Private Properties
  private var _environment: AppEnvironmentProtocol?
  private var _apiService: APIServiceProtocol?
  
  // MARK: - Init
  private init() {}
}

// MARK: - Services
extension ServiceLocator {
  var environment: AppEnvironmentProtocol {
    guard let environment = _environment else {
      let environment = AppEnvironment.shared
      _environment = environment
      return environment
    }
    return environment
  }
  
  var apiService: APIServiceProtocol {
    guard let apiService = _apiService else {
      let apiService = APIService()
      _apiService = apiService
      return apiService
    }
    return apiService
  }
}
