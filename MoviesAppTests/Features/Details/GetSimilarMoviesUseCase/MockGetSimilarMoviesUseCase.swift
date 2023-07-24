//
//  MockGetSimilarMoviesUseCase.swift
//  MoviesAppTests
//
//  Created by Mahmoud Aziz on 24/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

class MockGetSimilarMoviesUseCase: GetSimilarMoviesUseCaseProtocol {
  let result: Result<SimilarMovies, APIError>
  
  init(result: Result<SimilarMovies, APIError>) {
    self.result = result
  }
  
  func execute(id: Int, completion: @escaping ResultClosure<SimilarMovies>) {
    completion(result)
  }
}

