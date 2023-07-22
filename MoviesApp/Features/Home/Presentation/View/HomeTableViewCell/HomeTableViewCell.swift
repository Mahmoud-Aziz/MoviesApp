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
  @IBOutlet private weak var ratingInfoView: LeadingInfoView!
  @IBOutlet private weak var posterImageView: UIImageView!

  override func prepareForReuse() {
    super.prepareForReuse()
    posterImageView = nil
  }
  
  func configure(with data: Movie?) {
    guard let data else { return }
    titleLabel.text = data.title
    releaseYearLabel.text = data.releaseDate ?? "N/A"
    let rate = Int(data.voteAverage ?? 0.0)
    let textualRate = rate == .zero ? "N/A" : String(rate)
    ratingInfoView.configure(title: textualRate, description: "average votes")
  }
}
