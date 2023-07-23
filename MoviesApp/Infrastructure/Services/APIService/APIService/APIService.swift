//
//  APIService.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

// MARK: - APIService
protocol APIServiceProtocol {
  func sendRequest<T: Decodable>(decodable: T.Type, request: URLRequest, completion: @escaping ResultClosure<T>)
}

// MARK: - APIService
class APIService: APIServiceProtocol {
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
  
  func sendRequest<T: Decodable>(decodable: T.Type, request: URLRequest, completion: @escaping ResultClosure<T>) {
    let task = session.dataTask(with: request) { data, response, error in
      DispatchQueue.main.async {
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
          completion(.failure(APIError.failedRequest))
          return
        }
        guard statusCode != 401 else {
          completion(.failure(APIError.failureStatusCode))
          return
        }
        guard (200 ..< 300).contains(statusCode) else {
          completion(.failure(APIError.failureStatusCode))
          return
        }
        if error != nil {
          completion(.failure(APIError.failedRequest))
          return
        }
        guard let data else {
          completion(.failure(APIError.corruptedData))
          return
        }
        do {
          let response = try JSONDecoder().decode(decodable.self, from: data)
          completion(.success(response))
        } catch {
          debugPrint(error)
          completion(.failure(APIError.mappingError))
        }
      }
    }
    task.resume()
  }
}
