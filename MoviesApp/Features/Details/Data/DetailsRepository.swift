//
//  DetailsRepository.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

// MARK: - DetailsRepositoryProtocol
protocol DetailsRepositoryProtocol {
  func getSimilarMovies(id: Int, completion: @escaping ResultClosure<SimilarMovies>)
  func getMovieCast(id: Int, completion: @escaping ResultClosure<MovieCast>)
}

// MARK: - DetailsRepository
class DetailsRepository: DetailsRepositoryProtocol {
  private var service: APIServiceProtocol
  
  init(service: APIServiceProtocol = APIService()) {
    self.service = service
  }
  
  
  func getSimilarMovies(id: Int, completion: @escaping ResultClosure<SimilarMovies>) {
    let request = APIBuilder()
      .setPath(.movie, suffixes: [String(id), "similar"])
      .setParameters(key: .movieID, value: String(id))
      .build()
    
    service.sendRequest(decodable: SimilarMovies.self, request: request, completion: completion)
  }
  
  func getMovieCast(id: Int, completion: @escaping ResultClosure<MovieCast>) {
    let request = APIBuilder()
      .setPath(.movie, suffixes: [String(id), "credits"])
      .setParameters(key: .movieID, value: String(id))
      .build()
    
    service.sendRequest(decodable: MovieCast.self, request: request, completion: completion)
  }
}
