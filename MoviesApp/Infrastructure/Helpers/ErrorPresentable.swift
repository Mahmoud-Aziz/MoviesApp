//
//  ErrorPresentable.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

public protocol ErrorPresentable: Error {
  var message: String { get }
  var image: UIImage? { get }
  var alert: UIAlertController { get }
}
