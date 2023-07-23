//
//  FailureView.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

public class FailureView: UIView {

  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var descriptionLabel: UILabel!

  override public init(frame: CGRect) {
    super.init(frame: frame)
    loadfromNib()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    loadfromNib()
  }

  public func configure(image: UIImage?, description: String?) {
    imageView.image = image
    descriptionLabel.text = description
  }
}
