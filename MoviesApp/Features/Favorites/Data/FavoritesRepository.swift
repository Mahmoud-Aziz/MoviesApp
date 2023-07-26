//
//  FavoritesRepository.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 26/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation
import CoreData

// MARK: - FavoritesRepositoryProtocol
protocol FavoritesRepositoryProtocol {
  func fetchFavoriteMovies(completion: @escaping FavoriteMovieResultClosure)
  func clearAllFavoriteMovies(completion: (Result<(), Error>) -> Void)
}

// MARK: - FavoritesRepository
class FavoritesRepository: FavoritesRepositoryProtocol {
  private let context: NSManagedObjectContext
  
  init(context: NSManagedObjectContext = CoreDataManager.shared.managedObjectContext) {
    self.context = context
  }
  
  func fetchFavoriteMovies(completion: @escaping FavoriteMovieResultClosure) {
    let fetchRequest: NSFetchRequest<FavoriteMovieEntity> = FavoriteMovieEntity.fetchRequest()
    do {
      let movieEntities = try context.fetch(fetchRequest)
      let favoriteMovies = movieEntities.map { movieEntity in
        return FavoriteMovie(
          id: Int(movieEntity.id),
          title: movieEntity.title ?? "",
          subtitle: movieEntity.subtitle ?? "")
      }
      completion(.success(favoriteMovies))
    } catch {
      completion(.failure(error))
    }
  }
  
  func clearAllFavoriteMovies(completion: (Result<(), Error>) -> Void) {
    let fetchRequest: NSFetchRequest<FavoriteMovieEntity> = FavoriteMovieEntity.fetchRequest()
    do {
      let movies = try context.fetch(fetchRequest)
      for movie in movies {
        context.delete(movie)
      }
      CoreDataManager.shared.saveContext()
      completion(.success(()))
    } catch {
      completion(.failure(error))
    }
  }
}
