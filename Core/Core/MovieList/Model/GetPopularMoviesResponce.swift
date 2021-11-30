//
//  GetPopularMoviesResponce.swift
//  Core
//
//  Created by Lasha Maruashvili on 29.11.21.
//

import Foundation

public struct GetPopularMoviesResponce: Codable {
   public let page: Int
   public let results: [MovieData]

    enum CodingKeys: String, CodingKey {
        case page, results
    }
}

// MARK: - Result
public struct MovieData: Codable {
   public let backdropPath: String
   public let id: Int
   public let originalTitle, overview: String
   public let posterPath, title: String
   public let voteAverage: Double
   public let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
