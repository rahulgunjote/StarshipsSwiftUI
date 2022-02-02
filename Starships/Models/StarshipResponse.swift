//
//  StarshipResponse.swift
//  Starships
//
//  Created by Rahul Gunjote on 2/2/2022.
//

import Foundation

// MARK: - StarshipResponse
struct StarshipResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Starship]?
}
