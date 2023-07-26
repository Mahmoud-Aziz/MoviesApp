//
//  DetailsRepository.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 23/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import Foundation
import CoreData

// MARK: - DetailsRepositoryProtocol
protocol DetailsRepositoryProtocol {
  func getSimilarMovies(id: Int, completion: @escaping ResultClosure<SimilarMovies>)
  func getMovieCast(id: Int, completion: @escaping ResultClosure<MovieCast>)
  func downloadMoviePoster(url: URL, completion: @escaping ResultClosure<Data>)
  func saveFavoriteMovie(_ movieDetails: MovieDetailsViewData)
}

// MARK: - DetailsRepository
class DetailsRepository: DetailsRepositoryProtocol {
  private var service: APIServiceProtocol
  private let context = CoreDataManager.shared.managedObjectContext
  
  init(service: APIServiceProtocol = APIService()) {
    self.service = service
  }
  
  func getSimilarMovies(id: Int, completion: @escaping ResultClosure<SimilarMovies>) {
    let request = APIBuilder()
      .setPath(.movie, suffixes: [String(id), "similar"])
      .setParameters(key: .movieID, value: String(id))
      .build()
    
    service.sendRequest(decodable: SimilarMovies.self, request: request, completion: completion)
  }
  
  func getMovieCast(id: Int, completion: @escaping ResultClosure<MovieCast>) {
    let request = APIBuilder()
      .setPath(.movie, suffixes: [String(id), "credits"])
      .setParameters(key: .movieID, value: String(id))
      .build()
    
    service.sendRequest(decodable: MovieCast.self, request: request, completion: completion)
  }
  
  func downloadMoviePoster(url: URL, completion: @escaping ResultClosure<Data>) {
    service.downloadImage(from: url, completion: completion)
  }
  
  func saveFavoriteMovie(_ movieDetails: MovieDetailsViewData) {
    let fetchRequest: NSFetchRequest<FavoriteMovieEntity> = FavoriteMovieEntity.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %d", movieDetails.id)
    
    do {
      let existingMovies = try context.fetch(fetchRequest)
      if let existingMovie = existingMovies.first {
        // Item with the same ID already exists, you can update it or skip saving it again.
        // For example, to update, you can do the following:
        existingMovie.title = movieDetails.title
        existingMovie.subtitle = movieDetails.subtitle
        
        CoreDataManager.shared.saveContext()
      } else {
        // Item with the same ID doesn't exist, save it as a new item.
        let movieEntity = FavoriteMovieEntity(context: context)
        movieEntity.title = movieDetails.title
        movieEntity.subtitle = movieDetails.subtitle
        movieEntity.id = Int32(movieDetails.id)

        CoreDataManager.shared.saveContext()
      }
    } catch {
      return
    }
  }
}
