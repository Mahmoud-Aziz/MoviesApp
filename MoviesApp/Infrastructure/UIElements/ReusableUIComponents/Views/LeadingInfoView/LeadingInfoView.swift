//
//  LeadingInfoView.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

class LeadingInfoView: UIView {

  @IBOutlet private weak var titleLabel: TitleLabel!
  @IBOutlet private weak var descriptionLabel: DescriptionLabel!

  override init(frame: CGRect) {
    super.init(frame: frame)
    loadfromNib()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    loadfromNib()
  }

  func configure(title: String?, description: String?) {
    titleLabel.text = title
    descriptionLabel.text = description
  }
}
