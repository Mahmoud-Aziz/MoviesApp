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
  let adult: Bool
  let backdropPath: String?
  let genreIDS: [Int]
  let id: Int
  let originalLanguage, originalTitle, overview: String
  let popularity: Double
  let posterPath: String?
  let releaseDate, title: String
  let video: Bool
  let voteAverage: Double
  let voteCount: Int
  
  enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
    case genreIDS = "genre_ids"
    case id
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case overview, popularity
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case title, video
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}
