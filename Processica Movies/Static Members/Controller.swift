//
//  Controller.swift
//  Processica Movies
//
//  Created by Lasha Maruashvili on 29.11.21.
//

import Foundation
import UIKit

class Controller {
    
    static private let appDependencyContainer = AppDependencyContainer()
    
    static func getMainNavigationController() -> UINavigationController {
        let nc = UINavigationController()
        let vc = Controller.getMovieListViewController()
        nc.setViewControllers([vc], animated: false)
        return nc
    }
    
    static func getMovieListViewController() -> MovieListViewController {
        let viewModel = appDependencyContainer.movieListDependencies()
        let vc = MovieListViewController.instantiateFromStoryboard()
        vc.viewModel = viewModel
        return vc
    }
    
    static func getMovieDetailsViewController() -> MovieDetailsViewController {
        let vc = MovieDetailsViewController.instantiateFromStoryboard()
        return vc
    }
}
