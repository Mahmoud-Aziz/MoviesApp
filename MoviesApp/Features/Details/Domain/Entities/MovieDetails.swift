//
//  MovieDetails.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

// MARK: - MovieDetails
struct MovieDetails: Decodable {
  let id: Int
  let overview: String
  let posterPath: String
  let releaseDate: String
  let revenue, runtime: Int
  let status, title: String
  let voteAverage: Double
  let tagline: String
  
  enum CodingKeys: String, CodingKey {
    case id 
    case overview
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case revenue, runtime
    case status, title
    case voteAverage = "vote_average"
    case tagline
  }
}
