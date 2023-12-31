//
//  UIFont+Extension.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

extension UIFont {
  enum FontSize: CGFloat {
    case headerExtra = 30
    case header = 25
    case title = 20
    case subtitle = 15
    case description = 14
  }
  
  static var header: UIFont {
    let size = FontSize.header.rawValue
    return UIFont(name: "Roboto-Regular", size: size) ?? .systemFont(ofSize: size)
  }
  
  static var headerExtra: UIFont {
    let size = FontSize.headerExtra.rawValue
    return UIFont(name: "Roboto-Regular", size: size) ?? .systemFont(ofSize: size)
  }
  
  static var title: UIFont {
    let size = FontSize.title.rawValue
    return UIFont(name: "Roboto-Regular", size: size) ?? .systemFont(ofSize: size)
  }
  
  static var subtitle: UIFont {
    let size = FontSize.subtitle.rawValue
    return UIFont(name: "Roboto-Thin", size: size) ?? .systemFont(ofSize: size)
  }
  
  static var description: UIFont {
    let size = FontSize.description.rawValue
    return UIFont(name: "Roboto-Light", size: size) ?? .systemFont(ofSize: size)
  }
}
