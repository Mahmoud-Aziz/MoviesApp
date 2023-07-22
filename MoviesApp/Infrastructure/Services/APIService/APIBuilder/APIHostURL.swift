//
//  APIHostURL.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

enum APIHostURL {
    case baseURL

    var url: URL? {
        let url: String
        switch self {
        case .baseURL:
            url = ServiceLocator.shared.environment.baseURL
            return URL(string: url)
        }
    }
}
