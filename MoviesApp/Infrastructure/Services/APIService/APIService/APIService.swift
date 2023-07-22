//
//  APIService.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

typealias ResultClosure<T: Decodable> = (Result<T, APIError>) -> Void

// MARK: - APIService

protocol APIServiceProtocol {
    func sendRequest<T: Decodable>(_ decodable: T.Type, request: URLRequest, completion: @escaping ResultClosure<T>)
}

// MARK: - APIService

class APIService: APIServiceProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func sendRequest<T: Decodable>(_ decodable: T.Type, request: URLRequest, completion: @escaping ResultClosure<T>) {
        let task = session.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
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
                    completion(.failure(APIError.mappingError))
                }
            }
        }
        task.resume()
    }
}
