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
  let movies: [Movie]
  
  enum CodingKeys: String, CodingKey {
    case movies = "results"
  }
}
