//
//  Controller.swift
//  Processica Movies
//
//  Created by Lasha Maruashvili on 29.11.21.
//

import Foundation

class Controller {
    
    static private let appDependencyContainer = AppDependencyContainer()
    
    static func getMovieListViewController() -> MovieListViewController {
        let viewModel = appDependencyContainer.movieListDependencies()
        let vc = MovieListViewController.instantiateFromStoryboard()
        vc.viewModel = viewModel
        return vc
    }
}
