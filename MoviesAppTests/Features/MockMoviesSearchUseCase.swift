//
//  MockMoviesSearchUseCase.swift
//  MoviesAppTests
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

class MockMoviesSearchUseCase: SearchMoviesUseCaseProtocol {
  var mockResult: PopularMovies!
  var isSuccessful: Bool = false
  var mockError: APIError = .failedRequest
  var executeCallCount: Int = .zero
  var lastQuery: String!

  func execute(query: String, completion: @escaping ResultClosure<PopularMovies>) {
    isSuccessful ? completion(.success(mockResult)) : completion(.failure(mockError))
  }
}
