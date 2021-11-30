//
//  NetworkManager.swift
//  Core
//
//  Created by Lasha Maruashvili on 29.11.21.
//

import Foundation
import Combine

class NetworkManager<Model> : NSObject, URLSessionTaskDelegate where Model:Codable {
    
    private var subscribers : Set<AnyCancellable>
    
    typealias ResponseClosure = (Model) -> Void
    typealias ErrorClosure = (PError) -> Void
    
    static var shared: NetworkManager<Model> {
        return NetworkManager<Model>()
    }
    
    public override init() {
        self.subscribers = Set<AnyCancellable>()
    }
    
    func sendRequest(path: String, requestMethod: RequestMethod, params: [URLQueryItem], error: @escaping(ErrorClosure), response: @escaping(ResponseClosure)) {
        
        var urlBuilder = Network.apiUrl
        urlBuilder.path = path
        
        urlBuilder.queryItems = params
        
        guard let url = urlBuilder.url else {
            fatalError("Problem Generating URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = requestMethod.rawValue
        
        // HTTP Headers
        request.allHTTPHeaderFields = Network.headers
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.timeoutInterval = Network.timeOutInterval
        let session = URLSession(configuration: .default)
        session
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { data, _ in
//                data.prettyPrint()
                return try JSONDecoder().decode(Model.self, from: data)
            }.sink { completions in
                if case .failure(let err) = completions {
                    if (err as? URLError)?.code == .timedOut {
                        //Should Check Network Connection
                        let err = PError(errorType: .toBeShown, errorMessage: "Can't connect to server")
                        error(err)
                        return
                    } else if (err as? Swift.DecodingError) != nil {
                        let err = PError(errorType: .toBeShown, errorMessage: "Can't parse data")
                        error(err)
                        return
                    } else if (err as NSError).code == -1009 {
                        var err = PError(errorType: .other, errorMessage: "No Intrnet")
                        err.errorCode = -1009
                        error(err)
                        return
                    }
                    let err = PError(errorType: .toBeShown, errorMessage: err.localizedDescription)
                    error(err)
                    print(err)
                }
            } receiveValue: { decodedResponce in
                response(decodedResponce)
            }.store(in: &self.subscribers)
    }
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
