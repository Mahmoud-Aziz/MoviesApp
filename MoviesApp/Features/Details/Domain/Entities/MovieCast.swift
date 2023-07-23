//
//  MovieCast.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

struct MovieCast: Decodable {
  let cast: [Cast]
  let crew: [Crew]
}

// MARK: - Cast
struct Cast: Decodable {
  let name: String
  let popularity: Double
  
  enum CodingKeys: String, CodingKey {
    case name
    case popularity
  }
}

// MARK: - Crew
struct Crew: Decodable {
  let name: Bool
  let popularity: Double
  let department: String
  
  enum CodingKeys: String, CodingKey {
    case name
    case popularity
    case department
  }
}
