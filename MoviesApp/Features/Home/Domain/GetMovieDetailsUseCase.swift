//
//  GetMovieDetailsUseCase.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

// MARK: - DetailsUseCaseProtocol
protocol GetMovieDetailsUseCaseProtocol {
  func execute(id: Int, completion: @escaping ResultClosure<MovieDetails>)
}

// MARK: - DetailsUseCase
class GetMovieDetailsUseCase: GetMovieDetailsUseCaseProtocol {
  private var repository: HomeRepositoryProtocol
  
  init(repository: HomeRepositoryProtocol = HomeRepository()) {
    self.repository = repository
  }
  
  func execute(id: Int, completion: @escaping ResultClosure<MovieDetails>) {
    repository.getMovieDetails(id: id, completion: completion)
  }
}
