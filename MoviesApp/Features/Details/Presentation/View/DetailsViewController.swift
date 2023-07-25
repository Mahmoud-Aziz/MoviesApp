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
  @IBOutlet private weak var castTableView: UITableView!
  
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
    castTableView.reloadData()
  }
}

// MARK: - Setup View
private extension DetailsViewController {
  func setupView() {
    similarMoviesTableView.registerCellNib(HomeTableViewCell.self)
    castTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CastTableViewCell")
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

// MARK: - Similar movies and similar movies cast UITableViewDataSource
extension DetailsViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    switch tableView {
    case castTableView:
      return viewModel.castTableViewData.count
    default:
      return 1
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch tableView {
    case similarMoviesTableView:
      return viewModel.similarMoviesItemsCount
    case castTableView:
      return viewModel.getSimilarMoviesItemsCount(at: section)
    default:
      return .zero
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch tableView {
    case similarMoviesTableView:
      let similarMoviesCell: HomeTableViewCell = tableView.dequeue(cellForItemAt: indexPath)
      similarMoviesCell.configure(with: viewModel.getSimilarMovie(at: indexPath))
      return similarMoviesCell
    case castTableView:
      let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell", for: indexPath)
      let castMember = viewModel.getSimilarMoviesCast(at: indexPath)
      cell.textLabel?.text = castMember?.name
      cell.backgroundColor = .customSystemBackground
      return cell
    default:
      return UITableViewCell()
    }
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch tableView {
    case similarMoviesTableView:
      return "Similar Movies"
    case castTableView:
      return viewModel.getSimilarMoviesCastSectionTitle(at: section)
    default:
      return ""
    }
  }
}
