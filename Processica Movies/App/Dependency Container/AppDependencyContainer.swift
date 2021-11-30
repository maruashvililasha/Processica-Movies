//
//  AppDependencyContainer.swift
//  Processica Movies
//
//  Created by Lasha Maruashvili on 29.11.21.
//

import Foundation
import Core

class AppDependencyContainer: AppDependencyContainerInterface {
    func movieListDependencies() -> MovieListViewModel {
        let localDataSource = MoviesLocalDataSource()
        let remoteDataSource = MoviesRemoteDataSource()
        
        let dataRepo = MoviesDataRepository(remoteDataSource: remoteDataSource, localDataSource: localDataSource)
        
        let viewModel = MovieListViewModel(dataRepo: dataRepo)
        return viewModel
    }
}
