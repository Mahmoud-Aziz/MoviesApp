//
//  ViewModelState.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

public protocol Stateful {
    func mutate(newState: State)
}
