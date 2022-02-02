//
//  APIProtocol.swift
//  Starships
//
//  Created by Rahul Gunjote on 2/2/2022.
//

import Foundation
import Combine

protocol APIProtocol {
    
    associatedtype Response: Decodable

    var urlSession: URLSession { get }
    var jsonDecoder: JSONDecoder { get }
    
    func apiPublisher() -> AnyPublisher<Response, Error>
    func apiPublisher(with url: URL? ) -> AnyPublisher<Response, Error>
}
