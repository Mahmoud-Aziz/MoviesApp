//
//  UITableView+Extension.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

extension UITableView {
  func registerCellNib<T: UITableViewCell>(_ cellClass: T.Type) {
    let identifier = String(describing: T.self)
    let bundle = Bundle(for: cellClass.self)
    let nib = UINib(nibName: identifier, bundle: bundle)
    register(nib, forCellReuseIdentifier: identifier)
  }
  
  func dequeue<T: UITableViewCell>(cellForItemAt indexPath: IndexPath) -> T {
    let identifier = String(describing: T.self)
    guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
      fatalError("Couldn't find cell")
    }
    return cell
  }
}

extension UITableViewCell {
  func setSelectedCellColor(_ colorOnSelection: UIColor) {
    let backgroundView = UIView()
    backgroundView.backgroundColor = colorOnSelection
    selectedBackgroundView = backgroundView
  }
}
