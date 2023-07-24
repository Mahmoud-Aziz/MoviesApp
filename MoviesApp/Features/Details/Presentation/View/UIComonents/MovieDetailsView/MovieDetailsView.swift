//
//  MovieDetailsView.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 24/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

class MovieDetailsView: UIView {
  @IBOutlet private weak var posterImageView: UIImageView!
  @IBOutlet private weak var headerInfoView: VerticalInfoView!
  @IBOutlet private weak var voteAverageInfoView: LeadingInfoView!
  @IBOutlet private weak var revenueLabel: DescriptionLabel!
  @IBOutlet private weak var overviewLabel: DescriptionLabel!
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    loadfromNib()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    loadfromNib()
  }
  
  
  func configure(with data: MovieDetailsViewData) {
    headerInfoView.configure(title: data.title, subtitle: data.subtitle)
    posterImageView.image = data.poster
    voteAverageInfoView.configure(title: data.voteAverage, description: "vote average")
    overviewLabel.text = data.overview
    revenueLabel.text = data.revenue + " " + "revenue"
  }
}

struct MovieDetailsViewData {
  let title: String
  let subtitle: String
  let poster: UIImage
  let voteAverage: String
  let overview: String
  
  let revenue: String
  let tagline: String
}
