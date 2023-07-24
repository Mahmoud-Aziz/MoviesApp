//
//  MovieDetailsView.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 24/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

class MovieDetailsView: UIView {
  // MARK: - IBOutlet
  @IBOutlet private weak var posterImageView: UIImageView!
  @IBOutlet private weak var headerInfoView: VerticalInfoView!
  @IBOutlet private weak var taglineInfoView: LeadingInfoView!
  @IBOutlet private weak var voteAverageInfoView: LeadingInfoView!
  @IBOutlet private weak var revenueInfoView: LeadingInfoView!
  @IBOutlet private weak var overviewLabel: DescriptionLabel!
  @IBOutlet private weak var overviewLabelHeightConstraint: NSLayoutConstraint!
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    loadfromNib()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    loadfromNib()
  }
  
  // MARK: - Configure View
  func configure(with data: MovieDetailsViewData) {
    headerInfoView.configure(title: data.title, subtitle: data.subtitle)
    taglineInfoView.isHidden = (data.tagline ?? "").isEmpty
    taglineInfoView.configure(title: data.tagline, description: "movie tagline")
    voteAverageInfoView.configure(title: data.voteAverage, description: "vote average")
    overviewLabel.text = data.overview
    revenueInfoView.configure(title: data.revenue, description: "revenue")
  }
  
  func setPosterImage(data: Data) {
    guard let image = UIImage(data: data) else {
      posterImageView.image = .placeholder
      return
    }
    posterImageView.image = image
  }
}
