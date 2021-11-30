//
//  MovieListViewModel.swift
//  Processica Movies
//
//  Created by Lasha Maruashvili on 29.11.21.
//

import Foundation
import Core


class MovieListViewModel {
    
    var moviesPublisher : PPublisher<[MovieEntity]> = PPublisher([])
    var errorPublisher : PPublisher<PError?> = PPublisher(nil)
    var pagesLoaded = 1
    var dataRepo: MoviesDataRepositoryInterface
    
    public init(dataRepo: MoviesDataRepository) {
        self.dataRepo = dataRepo
    }
    
    func start() {
        moviesPublisher.value = []
        getMovies(page: 1)
    }
    
    private func getMovies(page: Int) {
        dataRepo.getPopularMovies(page: page) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let moviesData):
                self.pagesLoaded = page
                var movies = self.moviesPublisher.value
                moviesData.forEach({movies.append($0)})
                self.moviesPublisher.accept(movies)
            case .failure(let error):
                self.errorPublisher.accept(error)
            }
        }
    }
    
    func loadMore() {
        self.getMovies(page: pagesLoaded + 1)
    }
}
