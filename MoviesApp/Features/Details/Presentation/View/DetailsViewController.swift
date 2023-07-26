//
//  DetailsViewController.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
  // MARK: - IBOutlets
  @IBOutlet private weak var movieDetailsView: MovieDetailsView!
  @IBOutlet private weak var similarMoviesTableView: UITableView!
  @IBOutlet private weak var castTableViewContainerView: UIView!
  @IBOutlet private weak var castTableView: UITableView!
  
  // MARK: - Private properties
  private let viewModel: DetailsViewModel
  
  // MARK: - UI Elements
  let similarMoviesIndicator = UIActivityIndicatorView()
  let castIndicator = UIActivityIndicatorView()
  
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
    bindViewModelState()
    setupView()
    viewModel.performOnLoad()
  }
}

// MARK: - Setup View
private extension DetailsViewController {
  func setupView() {
    navigationItem.backBarButtonItem?.accessibilityIdentifier = "DetailsBackButton"
    similarMoviesTableView.registerCellNib(HomeTableViewCell.self)
    castTableView.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.castCellID)
    similarMoviesTableView.rowHeight = 100
    castIndicator.hidesWhenStopped = true
    similarMoviesIndicator.hidesWhenStopped = true
    movieDetailsView.configure(with: viewModel.movieDetailsViewData)
    bindPosterImageData()
    bindFavoriteButtonAction()
  }
  
  func bindViewModelState() {
    viewModel.state = { [weak self] state in
      guard let self else { return }
      switch state {
      case .loadingSimilarMoviesTableView:
        self.similarMoviesTableView.backgroundView = self.similarMoviesIndicator
        similarMoviesIndicator.startAnimating()
        
      case .loadingSimilarMoviesCastTableView:
        self.castTableView.backgroundView = self.castIndicator
        castIndicator.startAnimating()
        
      case .reloadSimilarMoviesTableView:
        similarMoviesIndicator.stopAnimating()
        self.similarMoviesTableView.reloadData()
        
      case .reloadSimilarMoviesCastTableView:
        castIndicator.stopAnimating()
        self.castTableView.reloadData()
        
      case .failedFetchingSimilarMovies(let error):
        similarMoviesIndicator.stopAnimating()
        let failureView = FailureView()
        failureView.configure(image: error.image, description: error.message)
        self.similarMoviesTableView.backgroundView = failureView
        self.castTableViewContainerView.isHidden = true
        
      case .failedFetchingSimilarMoviesCasts(let error):
        castIndicator.stopAnimating()
        let failureView = FailureView()
        failureView.configure(image: error.image, description: error.message)
        self.castTableView.backgroundView = failureView
      default:
        break
      }
    }
  }
  
  func bindPosterImageData() {
    viewModel.posterImageDataFetched = { [weak self] data in
      self?.movieDetailsView.setPosterImage(data: data)
    }
  }
  
  func bindFavoriteButtonAction() {
    movieDetailsView.addToFavoritesTapped = { [weak self] in
      self?.viewModel.saveFavoriteMovie()
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
      similarMoviesCell.setSelectedCellColor(.clear)
      return similarMoviesCell
    case castTableView:
      let castTableViewCell = tableView.dequeueReusableCell(withIdentifier: viewModel.castCellID, for: indexPath)
      let castMember = viewModel.getSimilarMoviesCast(at: indexPath)
      castTableViewCell.textLabel?.text = castMember?.name
      castTableViewCell.backgroundColor = .customSystemBackground
      castTableViewCell.setSelectedCellColor(.clear)
      return castTableViewCell
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

// MARK: - Similar movies and similar movies cast UITableViewDelegate
extension DetailsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
  }
}
