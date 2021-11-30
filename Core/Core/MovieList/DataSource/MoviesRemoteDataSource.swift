//
//  MoviesRemoteDataSource.swift
//  Core
//
//  Created by Lasha Maruashvili on 29.11.21.
//

import Foundation

public protocol MoviesRemoteDataSourceInterface {
    func getPopularMovies(page: Int, completion: @escaping (Result<GetPopularMoviesResponce, PError>) -> Void)
}

public class MoviesRemoteDataSource: MoviesRemoteDataSourceInterface {
    
    var requests = Set<NSObject>()
    
    required public init() {
    }
    
    public func getPopularMovies(page: Int, completion: @escaping (Result<GetPopularMoviesResponce, PError>) -> Void) {
        let path = "/3/movie/popular/"
        
        // parameters
        var params = Network.params
        params.append(URLQueryItem(name: "page", value: "\(page)"))
        
        let manager = NetworkManager<GetPopularMoviesResponce>.shared
        manager.sendRequest(path: path, requestMethod: .get, params: params) { [weak self] error in
            completion(.failure(error))
            self?.requests.remove(manager)
        } response: { [weak self] response in
            completion(.success(response))
            self?.requests.remove(manager)
        }
        self.requests.insert(manager)
    }
    
    
}
