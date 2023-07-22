//
//  LeadingInfoView.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Combine
import UIKit

public class LeadingInfoView: UIView {

  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var descriptionLabel: UILabel!

  override public init(frame: CGRect) {
    super.init(frame: frame)
    loadfromNib()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    loadfromNib()
  }

  public func configure(title: String?, description: String?) {
    titleLabel.text = title
    descriptionLabel.text = description
  }
}
