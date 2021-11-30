//
//  Network.swift
//  Core
//
//  Created by Lasha Maruashvili on 29.11.21.
//

import Foundation

class Network {
    static let timeOutInterval : Double = 10
    // Building URL
    static var urlBuilder = URLComponents()
    static let https = "https"
    static let host = "api.themoviedb.org"
    
    static let apiKey = "15f906f5ed76fffacf74d06f7d77f34e"
    
    static let posterPath = "https://image.tmdb.org/t/p/original/"

    static var apiUrl: URLComponents {
        urlBuilder.scheme = https
        urlBuilder.host = host
        return urlBuilder
    }
    
    static var headers: [String: String] {
        return ["Authorization": "Bearer \(apiKey)"]
    }
    
    static var params: [URLQueryItem] {
        let params : [URLQueryItem] = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "en-US")
        ]
        return params
    }
}
