//
//  DetailsViewModel.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

class DetailsViewModel {
  // MARK: - Use Cases
  private let getSimilarMoviesUseCase: GetSimilarMoviesUseCaseProtocol
  private let getSimilarMoviesCastsUseCase: GetSimilarMoviesCastsUseCaseProtocol
  private let downloadMoviePosterUseCase: DownloadMoviePosterUseCaseProtocol
  
  // MARK: - Private Properties
  private let group: DispatchGroup
  private let movieDetails: MovieDetails
  private(set) var randomFiveSimilarMovies: [Movie]?
  private(set) var castTableViewData: [[CastMember]] = []
  private let departments: [CastDepartment]
  
  // MARK: - Binding
  var posterImageDataFetched: DataClosure?
  var state: DetailsStateClosure?
  
  // MARK: - Init
  init(group: DispatchGroup = DispatchGroup(),
       movieDetails: MovieDetails,
       getSimilarMoviesUseCase: GetSimilarMoviesUseCaseProtocol = GetSimilarMoviesUseCase(),
       getSimilarMoviesCastsUseCase: GetSimilarMoviesCastsUseCaseProtocol = GetSimilarMoviesCastsUseCase(),
       downloadMoviePosterUseCase: DownloadMoviePosterUseCaseProtocol = DownloadMoviePosterUseCase(),
       departments: [CastDepartment] = [.acting, .directing]) {
    self.group = group
    self.movieDetails = movieDetails
    self.getSimilarMoviesUseCase = getSimilarMoviesUseCase
    self.getSimilarMoviesCastsUseCase = getSimilarMoviesCastsUseCase
    self.downloadMoviePosterUseCase  = downloadMoviePosterUseCase
    self.departments = departments
  }
}

// MARK: - Use Case Execution
extension DetailsViewModel {
  func getSimilarMovies(group: DispatchGroup? = nil) {
    state?(.loadingSimilarMoviesTableView)
    group?.enter()
    getSimilarMoviesUseCase.execute(id: movieDetails.id) { [weak self] result in
      switch result {
      case .success(let similarMovies):
        // Extract the similar movies from the response
        let filteredSimilarMovies = similarMovies.movies.compactMap { $0 }
        // Make sure they are different every time
        let shuffledSimilarMovies = Set(filteredSimilarMovies.shuffled())
        let count = similarMovies.movies.count
        // Make sure they are within the max count range
        let randomFiveSimilarMovies = Array(shuffledSimilarMovies.prefix(min(5, count)))
        self?.randomFiveSimilarMovies = randomFiveSimilarMovies
        self?.getSimilarMoviesCasts(similarMovies: randomFiveSimilarMovies)
        self?.state?(.reloadSimilarMoviesTableView)
      case .failure:
        self?.state?(.failedFetchingSimilarMovies(DetailsError.fetchingSimilarMoviesFailed))
      }
      group?.leave()
    }
  }
  
  func getSimilarMoviesCasts(similarMovies: [Movie]) {
    state?(.loadingSimilarMoviesCastTableView)
    getSimilarMoviesCastsUseCase.execute(similarMovies: similarMovies) { [weak self] result in
      switch result {
      case .success(let similarMoviesCasts):
        var castMembers: [CastMember] = []
        
        // Get the inner arrays of Cast
        let casts = similarMoviesCasts.compactMap({ $0.cast })
        // Get the inner arrays of Crews
        let crews = similarMoviesCasts.compactMap({ $0.crew })
        
        // Combine all inner Cast arrays into one array
        let combinedActors = casts.flatMap { $0 }
        // Ensure all elements are unique
        /*
         sets do not have an inherent order,
         and the elements are stored in a way that optimizes for uniqueness of element
         so this step must precede the sorting step
         */
        
        let uniqueActors = Set(combinedActors)
        // Sort the combined array based on the 'popularity' property in descending order
        let sortedUniqueActors = uniqueActors.sorted { $0.popularity > $1.popularity }
        // Ensure the final count is no more than 5
        let minActorsCount = min(5, sortedUniqueActors.count)
        let sortedTopFiveActorsCombined = Array(sortedUniqueActors.prefix(minActorsCount))
        
        // Add actors to an array of CastMember to combine them with directors in one group
        castMembers = sortedTopFiveActorsCombined.map({ cast in
          CastMember(name: cast.name, popularity: cast.popularity, department: .acting)
        })
        
        // Combine all inner Crews arrays into one array
        let combinedCrews = crews.flatMap { $0 }
        // Extract only directors
        let combinedDirectors = combinedCrews.filter({ $0.department == "Directing" })
        // Ensure all elements are unique
        
        /*
         sets do not have an inherent order,
         and the elements are stored in a way that optimizes for uniqueness of element
         so this step must precede the sorting step
         */
        
        let uniqueDirectors = Set(combinedDirectors)
        // Sort the combined array based on the 'popularity' property in descending order
        let sortedUniqueDirectors = uniqueDirectors.sorted { $0.popularity > $1.popularity }
        // Ensure the final count is no more than 5
        let minDirectorsCount = min(5, sortedUniqueDirectors.count)
        let sortedTopFiveDirectorsCombined = Array(sortedUniqueDirectors.prefix(minDirectorsCount))
        
        // Add directors to an array of CastMember to combine them with actors in one group
        castMembers += sortedTopFiveDirectorsCombined.map({ crew in
          CastMember(name: crew.name, popularity: crew.popularity, department: .directing)
        })
        
        // Group the whole case (actors/directors) by department
        let groupedData = Dictionary(grouping: castMembers, by: { $0.department })
        
        // Create the 2D table data
        guard let self else { return }
        self.castTableViewData = self.departments.compactMap({ groupedData[$0] })
        self.state?(.reloadSimilarMoviesCastTableView)
      case .failure:
        self?.state?(.failedFetchingSimilarMoviesCasts(DetailsError.fetchingSimilarMoviesCastsFailed))
      }
    }
  }
  
  func downloadMoviePoster(group: DispatchGroup? = nil) {
    group?.enter()
    downloadMoviePosterUseCase.execute(posterPath: movieDetails.posterPath) { [weak self] result in
      switch result {
      case .success(let imageData):
        self?.posterImageDataFetched?(imageData)
      case .failure:
        self?.posterImageDataFetched?(Data())
      }
      group?.enter()
    }
  }
}

// MARK: - View Helpers
extension DetailsViewModel {
  var movieDetailsViewData: MovieDetailsViewData {
    .init(title: movieDetails.title,
          subtitle: movieDetails.subtitle,
          voteAverage: movieDetails.formattedVoteAverage,
          overview: movieDetails.overview,
          revenue: movieDetails.formattedRevenue,
          tagline: movieDetails.tagline)
  }
  
  var similarMoviesItemsCount: Int {
    randomFiveSimilarMovies?.count ?? .zero
  }
  
  func performOnLoad() {
    getSimilarMovies(group: group)
    downloadMoviePoster(group: group)
  }
  
  func getSimilarMovie(at indexPath: IndexPath) -> Movie? {
    guard let randomFiveSimilarMovies else { return nil }
    return randomFiveSimilarMovies[indexPath.row]
  }
  
  func getSimilarMoviesCast(at indexPath: IndexPath) -> CastMember? {
    castTableViewData[indexPath.section][indexPath.row]
  }
  
  func getSimilarMoviesItemsCount(at section: Int) -> Int {
    castTableViewData[section].count
  }
  
  func getSimilarMoviesCastSectionTitle(at section: Int) -> String {
    let department = departments[section]
    return department.headerTitle
  }
  
  var castCellID: String {
    "CastTableViewCell" 
  }
}
