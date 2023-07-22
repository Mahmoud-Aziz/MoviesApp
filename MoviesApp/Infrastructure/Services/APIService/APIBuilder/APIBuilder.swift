//
//  APIBuilder.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

final class APIBuilder {
  private var hostURL: URL?
  private var path: String?
  private var method: HTTPMethod
  private var headers: [HeaderKeys: String]
  private var accessToken: String
  
  init(serviceLocator: ServiceLocatorProtocol = ServiceLocator.shared) {
    hostURL = APIHostURL.baseURL.url
    method = .get
    headers = [.accept: "application/json"]
    accessToken = serviceLocator.environment.apiKey
  }
  
  func setHost(_ host: APIHostURL) -> APIBuilder {
    guard let url = host.url else {
      fatalError("Invalid Host URL")
    }
    hostURL = url
    return self
  }
  
  func setPath(_ path: APIEndPoints) -> APIBuilder {
    self.path = path.rawValue
    return self
  }
  
  func setMethod(_ method: HTTPMethod) -> APIBuilder {
    self.method = method
    return self
  }
  
  @discardableResult public func setAccessToken() -> APIBuilder {
    headers[.authorization] = accessToken
    return self
  }
  
  public func setHeader(_ key: HeaderKeys, _ value: String) -> APIBuilder {
    headers[key] = value
    return self
  }
  
  func build() -> URLRequest {
    guard let baseURL = hostURL, let path = path else {
      fatalError("Invalid base url or path")
    }
    let url = baseURL.appendingPathComponent(path)
    let components = URLComponents(string: url.absoluteString)
    guard let components, let url = components.url else {
      fatalError("Error Getting URL from URLComponents In RequestBuilder")
    }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    setAccessToken()
    for header in headers {
      urlRequest.addValue(header.value, forHTTPHeaderField: header.key.rawValue)
    }
    return urlRequest
  }
}
