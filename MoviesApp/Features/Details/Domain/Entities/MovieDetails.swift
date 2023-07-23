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
  let adult: Bool
  let genres: [Genre]
  let originalLanguage, overview: String
  let posterPath: String
  let productionCompanies: [ProductionCompany]
  let productionCountries: [ProductionCountry]
  let releaseDate: String
  let revenue, runtime: Int
  let spokenLanguages: [SpokenLanguage]
  let status, title: String
  let video: Bool
  let voteAverage, voteCount: Int
  
  enum CodingKeys: String, CodingKey {
    case adult
    case genres
    case originalLanguage = "original_language"
    case overview
    case posterPath = "poster_path"
    case productionCompanies = "production_companies"
    case productionCountries = "production_countries"
    case releaseDate = "release_date"
    case revenue, runtime
    case spokenLanguages = "spoken_languages"
    case status, title, video
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}

// MARK: - Genre
struct Genre: Decodable {
  let name: String
}

// MARK: - ProductionCompany
struct ProductionCompany: Decodable {
  let name: String
  
  enum CodingKeys: String, CodingKey {
    case name
  }
}

// MARK: - ProductionCountry
struct ProductionCountry: Decodable {
  let name: String
  
  enum CodingKeys: String, CodingKey {
    case name
  }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Decodable {
  let name: String
  
  enum CodingKeys: String, CodingKey {
    case name
  }
}
