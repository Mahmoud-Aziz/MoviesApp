//
//  HomeRepository.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

// MARK: - HomeRepositoryProtocol
protocol HomeRepositoryProtocol {
  func getPopularMovies(pageCount: Int, completion: @escaping ResultClosure<PopularMovies>)
  func searchMovies(query: String, completion: @escaping ResultClosure<PopularMovies>)
  func getMovieDetails(id: Int, completion: @escaping ResultClosure<MovieDetails>)
}

// MARK: - HomeRepository
class HomeRepository: HomeRepositoryProtocol {
  private var service: APIServiceProtocol
  
  init(service: APIServiceProtocol = APIService()) {
    self.service = service
  }
  
  func getPopularMovies(pageCount: Int, completion: @escaping ResultClosure<PopularMovies>) {
    let request = APIBuilder()
      .setPath(.popularMovies)
      .setParameters(key: .pageCount, value: String(pageCount))
      .build()
    
    service.sendRequest(decodable: PopularMovies.self, request: request, completion: completion)
  }
  
  func searchMovies(query: String, completion: @escaping ResultClosure<PopularMovies>) {
    let request = APIBuilder()
      .setPath(.searchMovie)
      .setParameters(key: .query, value: query)
      .build()
    
    service.sendRequest(decodable: PopularMovies.self, request: request, completion: completion)
  }
  
  func getMovieDetails(id: Int, completion: @escaping ResultClosure<MovieDetails>) {
    let request = APIBuilder()
      .setPath(.movie, suffixes: [String(id)])
      .build()
    
    service.sendRequest(decodable: MovieDetails.self, request: request, completion: completion)
  }
}
