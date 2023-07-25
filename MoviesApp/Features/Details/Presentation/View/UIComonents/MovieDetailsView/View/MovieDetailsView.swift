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
  @IBOutlet private weak var voteAverageLabel: HeaderLabel!
  @IBOutlet private weak var revenueInfoView: LeadingInfoView!
  @IBOutlet private weak var overviewTextView: UITextView!
  @IBOutlet private weak var posterActivityIndicator: UIActivityIndicatorView!

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
    taglineInfoView.configure(title: data.tagline, description: "")
    voteAverageLabel.text = data.voteAverage
    voteAverageLabel.textColor = data.voteAverageTextColor
    overviewTextView.text = data.overview
    revenueInfoView.configure(title: data.revenue, description: "revenue")
    posterActivityIndicator.startAnimating()
  }
  
  func setPosterImage(data: Data) {
    guard let image = UIImage(data: data) else {
      posterImageView.image = .placeholder
      posterActivityIndicator.stopAnimating()
      return
    }
    posterActivityIndicator.stopAnimating()
    posterImageView.image = image
  }
}
