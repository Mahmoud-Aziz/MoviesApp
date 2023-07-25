//
//  VerticalInfoView.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 24/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

class VerticalInfoView: UIView {

  @IBOutlet private weak var titleLabel: TitleLabel!
  @IBOutlet private weak var subtitleLabel: SubtitleLabel!

  override init(frame: CGRect) {
    super.init(frame: frame)
    loadfromNib()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    loadfromNib()
  }

  func configure(title: String?, subtitle: String?) {
    titleLabel.text = title
    subtitleLabel.text = subtitle
  }
}
