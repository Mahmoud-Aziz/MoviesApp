//
//  SimilarMovies.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

// MARK: - SimilarMovies
struct SimilarMovies: Decodable {
  let page: Int
  let movies: [SimilarMovie]
  let totalPages, totalResults: Int
  
  enum CodingKeys: String, CodingKey {
    case page
    case movies = "results"
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

// MARK: - SimilarMovie
struct SimilarMovie: Decodable, Hashable {
  let id: Int
  let releaseDate, title: String
  let voteAverage: Double
  
  enum CodingKeys: String, CodingKey {
    case id 
    case releaseDate = "release_date"
    case title
    case voteAverage = "vote_average"
  }
}
