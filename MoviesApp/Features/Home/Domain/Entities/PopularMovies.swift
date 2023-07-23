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
struct Movie: Decodable {
  let id: Int
  let title: String
  private let releaseDate: String?
  private let voteAverage: Double?
  
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
    let textualRate = String(voteAverage ?? 0.0)
    return voteAverage == .zero ? .notAvailable : textualRate
  }
  
  var formattedReleaseDate: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    guard let releaseDate else {
      return .notAvailable
    }
    guard let date = dateFormatter.date(from: releaseDate) else {
      return .notAvailable
    }
    let calendar = Calendar.current
    let year = calendar.component(.year, from: date)
    return String(year)
  }
}
