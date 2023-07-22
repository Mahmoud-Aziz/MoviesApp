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

    @IBOutlet private var homeCollectionView: UICollectionView!

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - HomeViewController

private extension HomeViewController {
    func setupView() {
        homeCollectionView.registerCellNib(HomeCollectionViewCell.self)
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout _: UICollectionViewLayout,
                        sizeForItemAt _: IndexPath) -> CGSize
    {
        CGSize(width: collectionView.frame.width / 2 - 8, height: collectionView.frame.width / 2)
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeCollectionViewCell = collectionView.dequeue(cellForItemAt: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {}
