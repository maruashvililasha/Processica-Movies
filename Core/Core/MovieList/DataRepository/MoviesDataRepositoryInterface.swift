//
//  MoviesDataRepositoryInterface.swift
//  Core
//
//  Created by Lasha Maruashvili on 29.11.21.
//

import Foundation

public protocol MoviesDataRepositoryInterface {
    func getPopularMovies(page: Int, completion: @escaping(Result<[MovieEntity],PError>) -> Void)
}
