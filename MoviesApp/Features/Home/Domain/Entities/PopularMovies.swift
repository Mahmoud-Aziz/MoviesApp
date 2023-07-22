//
//  PopularMovies.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

// MARK: - PopularMovies
struct PopularMovies: Decodable {
  let currentPage: Int
  let movies: [Movie]
  let totalPages, totalResults: Int
  
  enum CodingKeys: String, CodingKey {
    case currentPage = "page"
    case movies = "results"
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

// MARK: - Movies
struct Movie: Decodable {
  let genreIDS: [Int]?
  let id: Int
  let title:String
  let posterPath, releaseDate: String?
  let voteAverage: Double?
  
  enum CodingKeys: String, CodingKey {
    case genreIDS = "genre_ids"
    case id
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case title
    case voteAverage = "vote_average"
  }
}
