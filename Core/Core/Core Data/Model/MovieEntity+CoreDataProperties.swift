//
//  MovieEntity+CoreDataProperties.swift
//  
//
//  Created by Lasha Maruashvili on 30.11.21.
//
//

import Foundation
import CoreData


extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var overview: String?
    @NSManaged public var poster: String?
    @NSManaged public var voteAverage: Double
    @NSManaged public var voteCount: Int64
    @NSManaged public var background: String?
    @NSManaged public var page: MovieListEntity?

}
