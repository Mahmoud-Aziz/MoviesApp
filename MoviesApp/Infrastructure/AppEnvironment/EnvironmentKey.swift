//
//  EnvironmentKey.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

enum EnvironmentKey: String {
  case serviceURLSchema = "App_api_service_url_schema"
  case baseURL = "App_api_base_url"
  case bundleIdentifier = "App_bundle_identifier"
  case appName = "App_name"
  case apiKey = "App_api_key"
  case accessToken = "TMDB_access_token"
}
