//
//  StarshipAPIService.swift
//  Starships
//
//  Created by Rahul Gunjote on 2/2/2022.
//

import Foundation
import Combine

struct StarshipAPIService: APIProtocol {
    
    typealias Response = StarshipResponse
    
    var urlSession: URLSession { .shared }

    var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    var baseUrl: URL?  {
        URL(string:"https://swapi.dev/api/starships/")
    }
}

// MARK: Data Task publishers
extension StarshipAPIService  {
    
    func apiPublisher() -> AnyPublisher<Response, Error> {
        
        guard let apiURL = baseUrl else {
            return Fail(error: APIError.urlRequest)
                .eraseToAnyPublisher()
        }
        return apiPublisher(with: apiURL)
    }
    
    func apiPublisher(with url: URL? ) -> AnyPublisher<Response, Error> {
        
        guard let apiURL =  url else {
            return Fail(error: APIError.urlRequest)
                .eraseToAnyPublisher()
        }
        let urlRequest = URLRequest(url: apiURL)
        
        return urlSession.dataTaskPublisher(for: urlRequest)
            .mapError { _ in APIError.network }
            .tryMap({ (data, response) in
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                    throw APIError.server
                }
                
                return data
            })
            .decode(type: Response.self, decoder: jsonDecoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
