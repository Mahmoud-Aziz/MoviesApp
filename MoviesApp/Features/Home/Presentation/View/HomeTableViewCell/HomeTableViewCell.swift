//
//  HomeTableViewCell.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
  @IBOutlet private weak var containerView: UIView!
  @IBOutlet private weak var movieTitleAndYearInfoView: VerticalInfoView!
  @IBOutlet private weak var voteAverageInfoView: LeadingInfoView!

  func configure(with data: Movie?) {
    guard let data else { return }

    voteAverageInfoView.configure(title: data.formattedVoteAverage, description: "vote average")
    movieTitleAndYearInfoView.configure(title: data.title, subtitle: data.formattedReleaseDate)
  }
}
