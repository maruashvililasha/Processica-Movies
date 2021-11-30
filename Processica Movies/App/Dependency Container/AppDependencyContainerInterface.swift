//
//  AppDependencyContainerInterface.swift
//  Processica Movies
//
//  Created by Lasha Maruashvili on 29.11.21.
//

import Foundation
import Core

protocol AppDependencyContainerInterface {
    // Movie List
    func movieListDependencies() -> MovieListViewModel
}
