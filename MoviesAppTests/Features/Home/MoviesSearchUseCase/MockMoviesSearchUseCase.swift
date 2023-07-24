//
//  MockMoviesSearchUseCase.swift
//  MoviesAppTests
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

class MockMoviesSearchUseCase: SearchMoviesUseCaseProtocol {
  var executeCallCount: Int = .zero
  var lastQuery: String!
  var result: Result<PopularMovies, APIError>!
  
  func execute(query: String, completion: @escaping ResultClosure<PopularMovies>) {
    completion(result)
  }
}
