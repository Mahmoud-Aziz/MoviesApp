//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

class HomeViewModel: BaseViewModel {
  // MARK: - Use Cases
  private var getPopularMoviesUseCase: GetPopularMoviesUseCaseProtocol
  
  // MARK: - Private Properties
  private var popularMovies: PopularMovies?
  private var currentPage = 1
  private var totalPages = 0
  
  // MARK: - Init
  init(getPopularMoviesUseCase: GetPopularMoviesUseCaseProtocol = GetPopularMoviesUseCase()) {
    self.getPopularMoviesUseCase = getPopularMoviesUseCase
    super.init()
    self.getPopularMoviesUseCase.delegate = self
  }
}

// MARK: - GetPopularMoviesUseCaseDelegate
extension HomeViewModel: GetPopularMoviesUseCaseDelegate {
  func succeed(with result: PopularMovies) {
    popularMovies = result
    totalPages = result.totalPages
    state?.mutate(newState: .reload)
  }
  
  func failed(with error: APIError) {
    state?.mutate(newState: .completed)
  }
}

// MARK: - View Helpers
extension HomeViewModel {
  func getData(pageCount: Int = 1) {
    state?.mutate(newState: .loading)
    getPopularMoviesUseCase.execute(pageCount: pageCount)
  }
  
  func prefetch(at indexPaths: [IndexPath]) {
    guard let popularMovies else { return }
    let lastIndex = popularMovies.movies.count - 1
    if indexPaths.contains(where: { $0.row == lastIndex }) {
      if currentPage < totalPages {
        currentPage += 1
        getData(pageCount: currentPage)
      }
    }
  }
  
  func getItem(at indexPath: IndexPath) -> Movie? {
    guard let popularMovies else { return nil }
    return popularMovies.movies[indexPath.row]
  }
  
  var itemsCount: Int {
    guard let popularMovies else { return .zero }
    return popularMovies.movies.count
  }
}
