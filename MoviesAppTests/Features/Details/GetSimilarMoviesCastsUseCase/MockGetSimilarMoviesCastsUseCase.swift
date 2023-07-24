//
//  MockGetSimilarMoviesCastsUseCase.swift
//  MoviesAppTests
//
//  Created by Mahmoud Aziz on 24/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

class MockGetSimilarMoviesCastsUseCase: GetSimilarMoviesCastsUseCaseProtocol {
  
  let result:  Result<[MovieCast], APIError>
  
  init(result: Result<[MovieCast], APIError>) {
    self.result = result
  }
  
  func execute(similarMovies: [Movie], completion: @escaping ResultClosure<[MovieCast]>) {
    completion(result)
  }
}
