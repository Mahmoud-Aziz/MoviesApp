//
//  DetailsViewController.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

class DetailsViewController: BaseViewController {
  // MARK: - IBOutlets
  @IBOutlet private weak var movieDetailsView: MovieDetailsView!
  
  // MARK: - Private properties
  private let viewModel: DetailsViewModel
  
  // MARK: - Init
  init(viewModel: DetailsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    viewModel.performOnLoad()
  }
}

// MARK: - Setup View
private extension DetailsViewController {
  func setupView() {
    bindPosterImageData()
    movieDetailsView.configure(with: viewModel.movieDetailsViewData)
  }
  
  func bindPosterImageData() {
    viewModel.posterImageDataFetched = { [weak self] data in
      self?.movieDetailsView.setPosterImage(data: data)
    }
  }
}
