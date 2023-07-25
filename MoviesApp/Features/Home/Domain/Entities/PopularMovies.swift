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

// MARK: - Movie
struct Movie: Decodable, Hashable {
  let id: Int
  let title: String
  let releaseDate: String?
  let voteAverage: Double?
  
  enum CodingKeys: String, CodingKey {
    case id
    case releaseDate = "release_date"
    case title
    case voteAverage = "vote_average"
  }
}

// MARK: - Processing Data
extension Movie {
  var formattedVoteAverage: String {
    guard let voteAverage else {
      return .notAvailable
    }
    let roundedNumber = String(format: "%.1f", voteAverage)
    return roundedNumber
  }
  
  var formattedReleaseDate: String {
    guard let releaseDate else {
      return .notAvailable
    }
    
    guard let releaseYear = releaseDate.extractedYearFromStringDate else {
      return .notAvailable
    }
    return releaseYear
  }
}
