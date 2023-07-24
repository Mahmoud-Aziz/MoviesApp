//
//  DetailsViewController.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

class DetailsViewController: BaseViewController {
  @IBOutlet private weak var movieDetailsView: MovieDetailsView!
  
  private let viewModel: DetailsViewModel
  
  init(viewModel: DetailsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    movieDetailsView.configure(with:
        .init(title: "The last mahmoud on earth", subtitle: "2019 - Realesed",
              poster: .notFound ?? UIImage(),
              voteAverage: "0.7",
              overview: "The last mahmoud on earth The last mahmoud on earth The last mahmoud on earth The last mahmoud on earth The last mahmoud arth The last mahmoud on earth",
              revenue: "120000000",
              tagline: ""))
    viewModel.performOnLoad()
  }
}
