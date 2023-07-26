//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

class HomeViewModel {
  // MARK: - Use Cases
  private var getPopularMoviesUseCase: GetPopularMoviesUseCaseProtocol
  private var searchMoviesUseCase: SearchMoviesUseCaseProtocol
  private var getMovieDetailsUseCase: GetMovieDetailsUseCaseProtocol
  
  // MARK: - Private Properties
  private(set) var movies: [Movie]?
  private(set) var currentPageCount = 1
  private(set) var totalPagesCount = 0
  private(set) var searchFilteredResults: [Movie]?
  private(set) var isFetching: Bool = false
  private var environment: AppEnvironmentProtocol
  
  // MARK: - Binding
  var state: HomeStateClosure?
  
  // MARK: - Init
  init(getPopularMoviesUseCase: GetPopularMoviesUseCaseProtocol = GetPopularMoviesUseCase(),
       searchMoviesUseCase: SearchMoviesUseCaseProtocol = SearchMoviesUseCase(),
       getMovieDetailsUseCase: GetMovieDetailsUseCaseProtocol = GetMovieDetailsUseCase(),
       environment: AppEnvironmentProtocol = AppEnvironment()) {
    self.getPopularMoviesUseCase = getPopularMoviesUseCase
    self.searchMoviesUseCase = searchMoviesUseCase
    self.getMovieDetailsUseCase = getMovieDetailsUseCase
    self.environment = ServiceLocator.shared.environment
  }
}

// MARK: - Use Case Execution
private extension HomeViewModel {
  func getPopularMovies(pageIndex: Int, showIndicator: Bool) {
    guard !isFetching else { return }
    if showIndicator {
      state?(.loading)
    }
    isFetching = true
    getPopularMoviesUseCase.execute(pageCount: pageIndex) { [weak self] result in
      guard let self else { return }
      self.isFetching = false
      switch result {
      case .success(let popularMovies):
        if pageIndex == 1 {
          self.movies = popularMovies.movies
          self.searchFilteredResults = popularMovies.movies
        } else {
          self.movies?.append(contentsOf: popularMovies.movies)
          self.searchFilteredResults?.append(contentsOf: popularMovies.movies)
        }
        self.totalPagesCount = popularMovies.totalPages
        self.state?(.reload)
      case .failure:
        self.state?(.failed(HomeError.fetchingPopularMoviesFailed))
      }
    }
  }
  
  func searchMovies(query: String, enableDebounce: Bool) {
    state?(.loading)
    searchMoviesUseCase.execute(query: query, enableDebounce: enableDebounce) { [weak self] result in
      guard let self else { return }
      switch result {
      case .success(let popularMovies):
        guard !popularMovies.movies.isEmpty else {
          self.state?(.failed(HomeError.searchFailed))
          return
        }
        self.searchFilteredResults = popularMovies.movies.filter { $0.title.lowercased().contains(query) }
        self.totalPagesCount = popularMovies.totalPages
        self.state?(.reload)
      case .failure:
        self.state?(.failed(HomeError.searchFailed))
      }
    }
  }
  
  func getMovieDetails(id: Int) {
    getMovieDetailsUseCase.execute(id: id) { [weak self] result in
      switch result {
      case .success(let movieDetails):
        self?.state?(.navigate(HomeRouter.details(movieDetails)))
      case .failure:
        self?.state?(.fetchingMovieDetailsFailed(HomeError.fetchingMovieDetailsFailed))
      }
    }
  }
}

// MARK: - View Helpers
extension HomeViewModel {
  var itemsCount: Int {
    searchFilteredResults?.count ?? .zero
  }
  
  var viewTitle: String {
    environment.appName
  }
  
  func performOnLoad() {
    getPopularMovies(pageIndex: 1, showIndicator: true)
  }
  
  func search(query: String?, enableDebounce: Bool) {
    guard let query = query?.lowercased(), !query.isEmpty else {
      resetSearch()
      return
    }
    searchMovies(query: query, enableDebounce: enableDebounce)
  }
  
  func resetSearch() {
    searchFilteredResults = movies
    state?(.reload)
  }
  
  func prefetch(at indexPaths: [IndexPath]) {
    guard let searchFilteredResults else { return }
    let lastIndex = searchFilteredResults.count - 10
    if indexPaths.contains(where: { $0.row == lastIndex }) {
      if currentPageCount < totalPagesCount {
        currentPageCount += 1
        getPopularMovies(pageIndex: currentPageCount, showIndicator: false)
      }
    }
  }
  
  func getItem(at indexPath: IndexPath) -> Movie? {
    guard let searchFilteredResults else { return nil }
    return searchFilteredResults[indexPath.row]
  }
  
  func didSelectItem(at index: IndexPath) {
    guard let searchFilteredResults else { return }
    let id = searchFilteredResults[index.row].id
    state?(.loading)
    getMovieDetails(id: id)
  }
}
