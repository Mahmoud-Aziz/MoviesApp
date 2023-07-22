//
//  APIError.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

enum APIError: Error {
    case badURLResponse
    case failureStatusCode
    case mappingError
    case corruptedData
    case failedRequest
    case unreachable
    case cancelled
    case badServerResponse
}
