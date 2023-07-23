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
  private var parameters: [String: String] = [:]
  private var accessToken: String
  
  init(serviceLocator: ServiceLocatorProtocol = ServiceLocator.shared) {
    hostURL = APIHostURL.baseURL.url
    method = .get
    headers = [.accept: "application/json"]
    accessToken = serviceLocator.environment.accessToken
    setParameters(key: .apiKey, value: serviceLocator.environment.apiKey)
  }
  
  func setHost(_ host: APIHostURL) -> Self {
    guard let url = host.url else {
      fatalError("Invalid Host URL")
    }
    hostURL = url
    return self
  }
  
  func setPath(_ path: APIEndPoints, suffixes: [String]? = nil) -> Self {
    guard let suffixes, !suffixes.isEmpty else {
      self.path = path.rawValue
      return self
    }
    let concatenatedSuffixes = suffixes.joined(separator: "/")
    self.path = path.rawValue + "/\(concatenatedSuffixes)"
    return self
  }
  
  func setMethod(_ method: HTTPMethod) -> Self {
    self.method = method
    return self
  }
  
  @discardableResult public func setAccessToken() -> Self {
    headers[.authorization] = accessToken
    return self
  }
  
  public func setHeader(_ key: HeaderKeys, _ value: String) -> Self {
    headers[key] = value
    return self
  }
  
  @discardableResult func setParameters(key: ParameterKeys, value: String) -> Self {
    parameters[key.rawValue] = value
    return self
  }
  
  func build() -> URLRequest {
    guard let baseURL = hostURL, let path = path else {
      fatalError("Invalid base url or path")
    }
    let url = baseURL.appendingPathComponent(path)
    var components = URLComponents(string: url.absoluteString)
    if !parameters.isEmpty {
      components?.queryItems = parameters.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
    }
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
