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
  let overview: String?
  let posterPath: String?
  let releaseDate: String?
  let revenue, runtime: Int?
  let status, title: String
  let voteAverage: Double?
  let tagline: String?
  
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

extension MovieDetails {
  var subtitle: String {
    let leadingPhrase = formattedReleaseDate + " " + "-"
    let centerPhrase =  " " + status + " "
    let trailingPhrase = "-" + " " + formattedRuntime
    return leadingPhrase + centerPhrase + trailingPhrase
  }
  
  var formattedVoteAverage: String {
    let roundedNumber = String(format: "%.1f", voteAverage ?? 0.0)
    return Int(roundedNumber) == .zero ? .notAvailable : roundedNumber
  }
  
  var formattedRevenue: String {
    guard let revenue else { return .notAvailable }
    return revenue.asCurrencyString 
  }

  private var formattedRuntime: String {
    let textualRuntime = String(runtime ?? 0) + " " + "mins"
    return runtime == .zero ? .notAvailable : textualRuntime
  }
  
  private var formattedReleaseDate: String {
    guard let releaseDate else {
      return .notAvailable
    }
    guard let releaseYear = releaseDate.extractedYearFromStringDate else {
      return .notAvailable
    }
    return releaseYear
  }
}
