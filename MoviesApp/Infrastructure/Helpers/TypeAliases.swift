//
//  TypeAliases.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation

typealias ResultClosure<T: Decodable> = (Result<T, APIError>) -> Void
typealias DataClosure = (Data) -> Void
typealias HomeStateClosure = (HomeState) -> Void
typealias DetailsStateClosure = (DetailsState) -> Void
typealias VoidClosure = () -> Void
typealias FavoriteMovieResultClosure = (Result<[FavoriteMovie], Error>) -> Void
typealias FavoritesStateClosure = (FavoritesState) -> Void
