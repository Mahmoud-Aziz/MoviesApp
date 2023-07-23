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
  @IBOutlet private weak var titleLabel: TitleLabel!
  @IBOutlet private weak var releaseYearLabel: SubtitleLabel!
  @IBOutlet private weak var voteAverageInfoView: LeadingInfoView!

  func configure(with data: Movie?) {
    guard let data else { return }
    titleLabel.text = data.title
    releaseYearLabel.text = data.formattedReleaseDate
    voteAverageInfoView.configure(title: data.formattedVoteAverage, description: "vote average")
  }
}
