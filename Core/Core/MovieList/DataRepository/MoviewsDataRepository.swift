//
//  MoviewsDataRepository.swift
//  Core
//
//  Created by Lasha Maruashvili on 29.11.21.
//

import Foundation

public class MoviesDataRepository: MoviesDataRepositoryInterface {
    
    let remoteDataSource : MoviesRemoteDataSourceInterface
    let localDataSource : MoviesLocalDataSourceInterface
    
    public init(remoteDataSource : MoviesRemoteDataSourceInterface, localDataSource : MoviesLocalDataSourceInterface) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource =  localDataSource
    }
    
    public func getPopularMovies(page: Int, completion: @escaping (Result<[MovieEntity], PError>) -> Void) {
        print("DataRepo: Getting popular movies page: \(page)")
        localDataSource.getPage(page: page) {[weak self] localResult in
            switch localResult {
            case .success(let pageEntity):
                if let pageEntity = pageEntity, pageEntity.isListValid(), let movies = pageEntity.moviesArray {
                    completion(.success(movies))
                } else {
                    self?.fetchMoviesAndSave(page: page) { result in
                        switch result {
                        case .success(let success):
                            guard success else {return}
                            self?.getPopularMovies(page: page, completion: completion)
                        case.failure(let error):
                            if error.errorCode == -1009 {
                                guard let movies = pageEntity?.moviesArray else {
                                    var errorMessage: String
                                    if page == 1 {
                                        errorMessage = "Local Database is empty, please connect to the internet to fetch data"
                                    } else {
                                       errorMessage = "Please connect to the internet for more movies"
                                    }
                                    var error = PError(errorType: .toBeShown, errorMessage: errorMessage)
                                    error.errorCode = -1009
                                    completion(.failure(error))
                                    return
                                }
                                completion(.success(movies))
                            }
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchMoviesAndSave(page: Int, completion: @escaping(Result<Bool, PError>) -> Void) {
        print("DataRepo: fetching popular movies page: \(page)")
        remoteDataSource.getPopularMovies(page: page) { [weak self] fetchResult in
            switch fetchResult {
            case .success(let page):
                self?.localDataSource.savePage(page: page, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
