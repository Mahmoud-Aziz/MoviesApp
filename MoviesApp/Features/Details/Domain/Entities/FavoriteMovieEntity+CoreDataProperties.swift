//
//  FavoriteMovieEntity+CoreDataProperties.swift
//  
//
//  Created by Mahmoud Aziz on 26/07/2023.
//
//

import Foundation
import CoreData

extension FavoriteMovieEntity {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovieEntity> {
    return NSFetchRequest<FavoriteMovieEntity>(entityName: "FavoriteMovieEntity")
  }
  
  @NSManaged public var title: String?
  @NSManaged public var subtitle: String?
  @NSManaged public var id: Int32
  
}
