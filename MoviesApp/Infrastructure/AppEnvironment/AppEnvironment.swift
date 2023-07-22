//
//  AppEnvironment.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

// MARK: - AppEnvironmentProtocol

protocol AppEnvironmentProtocol {
    var bundleID: String { get }
    var appName: String { get }
    var baseURL: String { get }
    var apiKey: String { get }
    func string(key: EnvironmentKey) -> String
    func boolean(key: EnvironmentKey) -> Bool
    func fetch(key: String) throws -> String
}

// MARK: - AppEnvironment

final class AppEnvironment {
    static let shared = AppEnvironment()

    // MARK: - Properties

    private lazy var infoDict: [String: Any] = {
        if let dict = Bundle.main.infoDictionary {
            return dict
        } else {
            fatalError("Couldn't find plist file")
        }
    }()

    /// Method to fetch String value from Info.plist
    /// - Parameter key: Key to fetch from Info.plist
    /// - Returns: Value fetched from Info.plist
    func string(key: EnvironmentKey) -> String {
        guard let value = try? fetch(key: key.rawValue) else {
            return ""
        }
        return value
    }

    /// Method to fetch Boolean value from Info.plist
    /// - Parameter key: Key to fetch from Info.plist
    /// - Returns: Value fetched from Info.plist
    func boolean(key: EnvironmentKey) -> Bool {
        Int(string(key: key)) == 1
    }

    /// Method to fetch String value from Info.plist
    /// - Parameter key: Key to fetch from Info.plist
    /// - Returns: Value fetched from Info.plist
    func fetch(key: String) throws -> String {
        guard let value = infoDict[key] as? String else {
            throw AppEnvironmentError.keyNotFound(key: key)
        }
        return value
    }
}

// MARK: - AppEnvironment + AppEnvironmentProtocol

extension AppEnvironment: AppEnvironmentProtocol {
    var bundleID: String {
        guard let bundleID = Bundle.main.bundleIdentifier else {
            fatalError("Couldn't get the bundle ID")
        }
        return bundleID
    }

    var appName: String {
        string(key: .appName)
    }

    var baseURL: String {
        let url = string(key: .baseURL)
        let schema = string(key: .serviceURLSchema)
        return schema + "://" + url
    }

    var apiKey: String {
        string(key: .apiKey)
    }

    var accessToken: String {
        string(key: .accessToken)
    }
}

enum AppEnvironmentError: Error, Equatable {
    case keyNotFound(key: String)
}
