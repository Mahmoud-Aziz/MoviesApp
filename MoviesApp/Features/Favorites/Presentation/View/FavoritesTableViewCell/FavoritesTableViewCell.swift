//
//  FavoritesTableViewCell.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 26/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
  @IBOutlet private weak var movieTitleAndYearInfoView: VerticalInfoView!
  
  func configure(with data: FavoriteMovie?) {
    guard let data else { return }
    movieTitleAndYearInfoView.configure(title: data.title, subtitle: data.subtitle)
  }
}
