//
//  GetPopularMoviesUseCase.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

// MARK: - GetPopularMoviesUseCaseProtocol
protocol GetPopularMoviesUseCaseProtocol {
  var delegate: GetPopularMoviesUseCaseDelegate? { get set }
  func execute(pageCount: Int)
}

// MARK: - GetPopularMoviesUseCaseDelegate
protocol GetPopularMoviesUseCaseDelegate: AnyObject {
  func succeed(with result: PopularMovies)
  func failed(with error: APIError)
}

// MARK: - GetPopularMoviesUseCase
class GetPopularMoviesUseCase: GetPopularMoviesUseCaseProtocol {
  private var repository: HomeRepositoryProtocol
  weak var delegate: GetPopularMoviesUseCaseDelegate?
  
  init(repository: HomeRepositoryProtocol = HomeRepository()) {
    self.repository = repository
  }
  
  func execute(pageCount: Int) {
    repository.getPopularMovies(pageCount: pageCount) { [weak self] result in
      switch result {
      case .success(let response):
        self?.delegate?.succeed(with: response)
      case .failure(let error):
        self?.delegate?.failed(with: error)
      }
    }
  }
}
