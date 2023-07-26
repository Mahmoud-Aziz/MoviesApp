//
//  MovieDetailsViewData.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 24/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

struct MovieDetailsViewData {
  let id: Int
  let title: String
  let subtitle: String
  let voteAverage: String
  let overview: String?
  let revenue: String
  let tagline: String?
  
  var voteAverageTextColor: UIColor {
    let voteAverage = Double(voteAverage)
    var color: UIColor = .clear
    guard let voteAverage else { return color }
    if voteAverage <= 5.0 {
      color = .systemRed
    } else if voteAverage <= 7.0 {
      color = .systemYellow
    } else if voteAverage <= 10.0 {
      color = .systemGreen
    }
    return color
  }
}
