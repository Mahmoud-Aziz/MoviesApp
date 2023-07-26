//
//  FavoritesViewController.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 26/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
  // MARK: - IBOutlet
  @IBOutlet private weak var favoritesTableView: UITableView!
  
  // MARK: - Private Properties
  private var viewModel: FavoritesViewModel
  
  // MARK: - Init
  init(viewModel: FavoritesViewModel = FavoritesViewModel()) {
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
    viewModel.fetchFavoriteMovie()
  }
}
// MARK: - Setup View
private extension FavoritesViewController {
  func setupView() {
    favoritesTableView.registerCellNib(FavoritesTableViewCell.self)
    favoritesTableView.rowHeight = 70
    favoritesTableView.backgroundView = emptyView
    bindViewModelState()
  }
  
  func bindViewModelState() {
    viewModel.state = { [weak self] state in
      self?.favoritesTableView.backgroundView = self?.emptyView
      switch state {
      case .reload:
        self?.favoritesTableView.reloadData()
        
      case .allSavedFavoritesCleared(let alert):
        self?.present(alert.alert, animated: true)
        
      case .fetchingFavoriteMoviesFailed(let error):
        let failureView = FailureView()
        failureView.configure(image: error.image, description: error.message)
        self?.favoritesTableView.backgroundView = failureView
        
      case .clearAllSavedFavoritesFailed(let error):
        self?.present(error.alert, animated: true)
        
      default:
        break
      }
    }
  }
  
  var emptyView: FailureView? {
    guard viewModel.itemsCount == .zero else { return nil }
    let failureView = FailureView()
    failureView.configure(image: .notFound, description: "Start adding your favorites to save them")
    return failureView
  }
}

// MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.itemsCount
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: FavoritesTableViewCell = tableView.dequeue(cellForItemAt: indexPath)
    cell.setSelectedCellColor(.clear)
    cell.configure(with: viewModel.getItem(at: indexPath))
    return cell
  }
}
// MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
  }
}

// MARK: - IBAction Methods
extension FavoritesViewController {
  @IBAction private func clearButtonTapped(_ sender: UIButton) {
    viewModel.clearAllFavoriteMovies()
  }
}
