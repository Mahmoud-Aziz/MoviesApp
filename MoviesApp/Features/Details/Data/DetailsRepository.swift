//
//  MovieDetailsRepository.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

// MARK: - MovieDetailsRepositoryProtocol
protocol MovieDetailsRepositoryProtocol {
  func getMovieDetails(id: Int, completion: @escaping ResultClosure<MovieDetails>)
  func getSimilarMovies(id: Int, completion: @escaping ResultClosure<PopularMovies>)
  func getMovieCast(id: Int, completion: @escaping ResultClosure<MovieCast>)
}

// MARK: - DetailsRepository
class MovieDetailsRepository: MovieDetailsRepositoryProtocol {
  private var service: APIServiceProtocol
  
  init(service: APIServiceProtocol = APIService()) {
    self.service = service
  }
  
  func getMovieDetails(id: Int, completion: @escaping ResultClosure<MovieDetails>) {
    let request = APIBuilder()
      .setPath(.movie, suffixes: [String(id)])
      .build()
  
    service.sendRequest(decodable: MovieDetails.self, request: request, completion: completion)
  }
  
  func getSimilarMovies(id: Int, completion: @escaping ResultClosure<PopularMovies>) {
    let request = APIBuilder()
      .setPath(.movie, suffixes: [String(id), "similar"])
      .setParameters(key: .movieID, value: String(id))
      .build()
    
    service.sendRequest(decodable: PopularMovies.self, request: request, completion: completion)
  }
  
  func getMovieCast(id: Int, completion: @escaping ResultClosure<MovieCast>) {
    let request = APIBuilder()
      .setPath(.movie, suffixes: [String(id), "credits"])
      .setParameters(key: .movieID, value: String(id))
      .build()
    
    service.sendRequest(decodable: MovieCast.self, request: request, completion: completion)
  }
}
