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
  private var searchMoviesUseCase: SearchMoviesUseCaseProtocol
  private var getMovieDetailsUseCase: GetMovieDetailsUseCaseProtocol
  private var environment: AppEnvironmentProtocol
  
  // MARK: - Private Properties
  private(set) var movies: [Movie]?
  private(set) var currentPage = 1
  private(set) var totalPages = 0
  private(set) var searchFilteredResults: [Movie]?
  
  // MARK: - Init
  init(getPopularMoviesUseCase: GetPopularMoviesUseCaseProtocol = GetPopularMoviesUseCase(),
       searchMoviesUseCase: SearchMoviesUseCaseProtocol = SearchMoviesUseCase(),
       getMovieDetailsUseCase: GetMovieDetailsUseCaseProtocol = GetMovieDetailsUseCase(),
       environment: AppEnvironmentProtocol = AppEnvironment()) {
    self.getPopularMoviesUseCase = getPopularMoviesUseCase
    self.searchMoviesUseCase = searchMoviesUseCase
    self.getMovieDetailsUseCase = getMovieDetailsUseCase
    self.environment = ServiceLocator.shared.environment
    super.init()
  }
}
// MARK: - Use Case Execution
private extension HomeViewModel {
  func getPopularMovies(pageCount: Int) {
    state?.update(newState: .loading)
    getPopularMoviesUseCase.execute(pageCount: pageCount) { [weak self] result in
      guard let self else { return }
      switch result {
      case .success(let popularMovies):
        self.movies = popularMovies.movies
        self.searchFilteredResults = popularMovies.movies
        self.totalPages = popularMovies.totalPages
        self.state?.update(newState: .reload)
      case .failure:
        self.state?.update(newState: .failed(HomeError.fetchingPopularMoviesFailed))
      }
    }
  }
  
  func searchMovies(query: String, enableDebounce: Bool) {
    state?.update(newState: .loading)
    searchMoviesUseCase.execute(query: query, enableDebounce: enableDebounce) { [weak self] result in
      guard let self else { return }
      switch result {
      case .success(let popularMovies):
        guard !popularMovies.movies.isEmpty else {
          self.state?.update(newState: .failed(HomeError.searchFailed))
          return
        }
        self.searchFilteredResults = popularMovies.movies.filter { $0.title.lowercased().contains(query) }
        self.totalPages = popularMovies.totalPages
        self.state?.update(newState: .reload)
      case .failure:
        self.state?.update(newState: .failed(HomeError.searchFailed))
      }
    }
  }
  
  func getMovieDetails(id: Int) {
    getMovieDetailsUseCase.execute(id: id) { [weak self] result in
      switch result {
      case .success(let movieDetails):
        self?.state?.update(newState: .navigate(HomeRouter.details(movieDetails)))
      case .failure:
        self?.state?.update(newState: .failed(HomeError.fetchingMovieDetailsFailed))
      }
    }
  }
}

// MARK: - View Helpers
extension HomeViewModel {
  func performOnLoad() {
    getPopularMovies(pageCount: 1)
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
    state?.update(newState: .reload)
  }
  
  func prefetch(at indexPaths: [IndexPath]) {
    guard let searchFilteredResults else { return }
    let lastIndex = searchFilteredResults.count - 1
    if indexPaths.contains(where: { $0.row == lastIndex }) {
      if currentPage < totalPages {
        currentPage += 1
        getPopularMovies(pageCount: currentPage)
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
    state?.update(newState: .loading)
    getMovieDetails(id: id)
  }
  
  var itemsCount: Int {
    searchFilteredResults?.count ?? .zero
  }
  
  var viewTitle: String {
    environment.appName
  }
}
