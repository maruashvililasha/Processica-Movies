//
//  MovieListEntity+CoreDataProperties.swift
//  
//
//  Created by Lasha Maruashvili on 30.11.21.
//
//

import Foundation
import CoreData


extension MovieListEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieListEntity> {
        return NSFetchRequest<MovieListEntity>(entityName: "MovieListEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var page: Int16
    @NSManaged public var movies: NSOrderedSet?
    
    public var moviesArray: [MovieEntity]? {
        let movesMutableSet = movies as? NSMutableOrderedSet
        return movesMutableSet?.array as? [MovieEntity]
    }

}

// MARK: Generated accessors for movies
extension MovieListEntity {

    @objc(insertObject:inMoviesAtIndex:)
    @NSManaged public func insertIntoMovies(_ value: MovieEntity, at idx: Int)

    @objc(removeObjectFromMoviesAtIndex:)
    @NSManaged public func removeFromMovies(at idx: Int)

    @objc(insertMovies:atIndexes:)
    @NSManaged public func insertIntoMovies(_ values: [MovieEntity], at indexes: NSIndexSet)

    @objc(removeMoviesAtIndexes:)
    @NSManaged public func removeFromMovies(at indexes: NSIndexSet)

    @objc(replaceObjectInMoviesAtIndex:withObject:)
    @NSManaged public func replaceMovies(at idx: Int, with value: MovieEntity)

    @objc(replaceMoviesAtIndexes:withMovies:)
    @NSManaged public func replaceMovies(at indexes: NSIndexSet, with values: [MovieEntity])

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: MovieEntity)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: MovieEntity)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSOrderedSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSOrderedSet)

}
