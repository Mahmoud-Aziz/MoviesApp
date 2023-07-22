//
//  RouteProtocol.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

public protocol RouteProtocol {
  var destination: UIViewController { get }
  var style: RouteStyle { get }
}
