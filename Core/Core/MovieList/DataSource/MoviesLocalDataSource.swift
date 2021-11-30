//
//  MoviesLocalDataSource.swift
//  Core
//
//  Created by Lasha Maruashvili on 29.11.21.
//

import Foundation
import CoreData

public protocol MoviesLocalDataSourceInterface {
    func getPage(page: Int, completion: @escaping (Result<MovieListEntity?, PError>) -> Void)
    func savePage(page: GetPopularMoviesResponce, completion: @escaping (Result<Bool, PError>) -> Void)
}

public class MoviesLocalDataSource: MoviesLocalDataSourceInterface {
    
    lazy var persistentContainer: NSPersistentContainer = {
        guard let bundle = Bundle(identifier: "com.maruashvililasha.Core") else {
            fatalError("Bundle not found")
        }
        guard let modelURL = bundle.url(forResource: "MoviesLocalDataModel", withExtension: "momd") else {
                fatalError("Error loading model from bundle")
        }
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let container = NSPersistentContainer(name: "MoviesLocalDataModel", managedObjectModel: mom)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    required public init() {
        
    }
    
    public func getPage(page: Int, completion: @escaping (Result<MovieListEntity?, PError>) -> Void) {
        do {
            let request = MovieListEntity.fetchRequest()
            request.predicate = NSPredicate(format: "page == \(page)")
            let pages = try context.fetch(request)
            completion(.success(pages.first))
        } catch (let error) {
            let error = PError(errorType: .toBeShown, errorMessage: error.localizedDescription, endpoint: "CoreData \(#function)")
            completion(.failure(error))
        }
    }
    
    private func persistPage(page: GetPopularMoviesResponce, completion: @escaping (Result<Bool, PError>) -> Void) {
        let movieListEntity = MovieListEntity(context: context)
        movieListEntity.date = Date()
        movieListEntity.page = Int16(page.page)
        page.results.forEach({ movieData in
            let movieEntity = MovieEntity(context: context)
            movieEntity.id = Int64(movieData.id)
            movieEntity.background = Network.posterPath + movieData.backdropPath
            movieEntity.name = movieData.originalTitle
            movieEntity.overview = movieData.overview
            movieEntity.poster = Network.posterPath + movieData.posterPath
            movieEntity.voteAverage = movieData.voteAverage
            movieEntity.voteCount  = Int64(movieData.voteCount)
            movieEntity.page = movieListEntity
        })
        do {
            try context.save()
            completion(.success(true))
        } catch (let error) {
            let error = PError(errorType: .toBeShown, errorMessage: error.localizedDescription, endpoint: "CoreData \(#function)")
            completion(.failure(error))
        }
        
    }
    
    public func savePage(page: GetPopularMoviesResponce, completion: @escaping (Result<Bool, PError>) -> Void) {
        delete(page: page.page) { [weak self] result in
            switch result {
            case .success(let success):
                guard success else {return}
                self?.persistPage(page: page, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func delete(page: Int, completion: @escaping (Result<Bool,PError>) -> Void) {
        getPage(page: page) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let page):
                guard let page = page else {
                    completion(.success(true))
                    return
                }
                if let movies  = page.moviesArray {
                    movies.forEach({self.context.delete($0)})
                }
                self.context.delete(page)
                do {
                    try self.context.save()
                    completion(.success(true))
                } catch (let error) {
                    let error = PError(errorType: .toBeShown, errorMessage: error.localizedDescription, endpoint: "CoreData \(#function)")
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
