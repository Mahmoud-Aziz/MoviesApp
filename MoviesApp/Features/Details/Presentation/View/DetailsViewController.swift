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
  @IBOutlet private weak var similarMoviesTableView: UITableView!

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
    bindViewModelState(viewModel)
    setupView()
    viewModel.performOnLoad()
  }
  
  // MARK: - State Management
  override func handleViewModelReloadState() {
    super.handleViewModelReloadState()
    similarMoviesTableView.reloadData()
  }
}

// MARK: - Setup View
private extension DetailsViewController {
  func setupView() {
    similarMoviesTableView.registerCellNib(HomeTableViewCell.self)
    similarMoviesTableView.rowHeight = 100
    movieDetailsView.configure(with: viewModel.movieDetailsViewData)
    bindPosterImageData()
  }
  
  func bindPosterImageData() {
    viewModel.posterImageDataFetched = { [weak self] data in
      self?.movieDetailsView.setPosterImage(data: data)
    }
  }
}

// MARK: - Similar Movies UITableViewDataSource
extension DetailsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.similarMoviesItemsCount
  }
 
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: HomeTableViewCell = tableView.dequeue(cellForItemAt: indexPath)
    cell.configure(with: viewModel.getSimilarMovie(at: indexPath))
    return cell
  }
}
