//
//  UI+Extension.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

extension UIView {
  @discardableResult
  func loadfromNib<T: UIView>() -> T? {
    let nibName = String(describing: type(of: self))
    guard let view = Bundle(for: type(of: self)).loadNibNamed(nibName, owner: self, options: nil)?.first as? T else {
      return nil
    }
    view.frame = bounds
    addSubview(view)
    return view
  }
}
