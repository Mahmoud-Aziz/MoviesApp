//
//  SaveFavoriteMovieUseCase.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 26/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

// MARK: - SaveFavoriteMovieUseCaseProtocol
protocol SaveFavoriteMovieUseCaseProtocol {
  func execute(movieDetails: MovieDetailsViewData)
}

// MARK: - SaveFavoriteMovieUseCase
class SaveFavoriteMovieUseCase: SaveFavoriteMovieUseCaseProtocol {
  private var repository: DetailsRepositoryProtocol
  
  init(repository: DetailsRepositoryProtocol = DetailsRepository()) {
    self.repository = repository
  }
  
  func execute(movieDetails: MovieDetailsViewData) {
    repository.saveFavoriteMovie(movieDetails)
  }
}
