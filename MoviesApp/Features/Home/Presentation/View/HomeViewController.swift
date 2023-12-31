//
//  HomeViewController.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

// MARK: - HomeViewController
class HomeViewController: UIViewController {
  // MARK: - IBOutlet
  @IBOutlet private weak var failureView: FailureView!
  @IBOutlet private weak var homeSearchBar: UISearchBar!
  @IBOutlet private weak var homeTableView: UITableView!
  
  // MARK: - Private Properties
  private var viewModel: HomeViewModel
  
  // MARK: - Init
  init(viewModel: HomeViewModel = HomeViewModel()) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModelState()
    setupView()
    viewModel.resetSearch()
    viewModel.performOnLoad()
  }
}

// MARK: - Setup View
private extension HomeViewController {
  func setupView() {
    title = viewModel.viewTitle
    homeTableView.registerCellNib(HomeTableViewCell.self)
    homeTableView.rowHeight = 100
    setupFavoriteBarButtonItem()
  }
  
  func bindViewModelState() {
    viewModel.state = { [weak self] state in
      self?.showLoader(state == .loading)
      switch state {
      case .reload:
        self?.homeTableView.isHidden = false
        self?.homeTableView.reloadData()
      case .failed(let error):
        self?.homeTableView.isHidden = true
        self?.failureView.configure(image: error.image, description: error.message)
      case .fetchingMovieDetailsFailed(let error):
        self?.present(error.alert, animated: true)
      case .navigate(let destination):
        self?.navigate(to: destination)
      default:
        break
      }
    }
  }
  
  func setupFavoriteBarButtonItem() {
    let rightBarButton = UIButton(type: .custom)
    rightBarButton.setImage(.favorites, for: .normal)
    rightBarButton.addTarget(self, action: #selector(rightBarButtonTapped), for: .touchUpInside)
    let rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
    navigationItem.rightBarButtonItem = rightBarButtonItem
  }
  
  @objc func rightBarButtonTapped() {
    navigate(to: HomeRouter.favorites)
  }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.itemsCount
  }
 
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: HomeTableViewCell = tableView.dequeue(cellForItemAt: indexPath)
    cell.configure(with: viewModel.getItem(at: indexPath))
    return cell
  }
}

// MARK: - Pagination
extension HomeViewController: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    viewModel.prefetch(at: indexPaths)
  }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    viewModel.didSelectItem(at: indexPath)
  }
}

// MARK: UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.search(query: searchBar.text, enableDebounce: true)
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    viewModel.search(query: searchBar.text, enableDebounce: false)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    viewModel.resetSearch()
  }
}
