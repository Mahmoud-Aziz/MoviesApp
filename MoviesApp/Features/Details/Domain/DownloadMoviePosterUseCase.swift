//
//  DownloadMoviePosterUseCase.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 24/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

// MARK: - DownloadMoviePosterUseCaseProtocol
protocol DownloadMoviePosterUseCaseProtocol {
  func execute(posterPath: String?, completion: @escaping ResultClosure<Data>)
}

// MARK: - DownloadMoviePosterUseCase
class DownloadMoviePosterUseCase: DownloadMoviePosterUseCaseProtocol {
  private var repository: DetailsRepositoryProtocol
  private var environment: AppEnvironmentProtocol

  init(repository: DetailsRepositoryProtocol = DetailsRepository()) {
    self.repository = repository
    environment = ServiceLocator.shared.environment
  }
  
  func execute(posterPath: String?, completion: @escaping ResultClosure<Data>) {
    guard let posterPath, !posterPath.isEmpty else {
      completion(.failure(.corruptedURL))
      return
    }
    let imageBaseURL = environment.imageBaseURL
    let imageSize = TMDBImageSize.w500.rawValue
    let concatenatedURL = imageBaseURL + imageSize + posterPath
    guard let url = URL(string: concatenatedURL) else {
      completion(.failure(.corruptedURL))
      return
    }
    repository.downloadMoviePoster(url: url, completion: completion)
  }
}
