//
//  UICollectionView+Extension.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

public extension UICollectionView {
  func registerCellNib<T: UICollectionViewCell>(_ cellClass: T.Type) {
    let identifier = String(describing: T.self)
    let bundle = Bundle(for: cellClass.self)
    let nib = UINib(nibName: identifier, bundle: bundle)
    register(nib, forCellWithReuseIdentifier: identifier)
  }
  
  func dequeue<T: UICollectionViewCell>(cellForItemAt indexPath: IndexPath) -> T {
    let identifier = String(describing: T.self)
    guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
      fatalError("Couldn't find cell")
    }
    return cell
  }
}
