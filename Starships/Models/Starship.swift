//
//  Starship.swift
//  Starships
//
//  Created by Rahul Gunjote on 2/2/2022.
//

import Foundation

// MARK: - Result
struct Starship: Codable, Identifiable {
    
    let id = UUID().uuidString
    let name: String
    let model, manufacturer, costInCredits: String?
    let length, maxAtmospheringSpeed, crew, passengers: String?
    let cargoCapacity, consumables, hyperdriveRating, mglt: String?
    let starshipClass: String?
    let pilots, films: [String]?
    let created, edited: String?
    let url: String
    var isFavorite = false

    enum CodingKeys: String, CodingKey {
        case name, model, manufacturer
        case costInCredits = "cost_in_credits"
        case length
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case crew, passengers
        case cargoCapacity = "cargo_capacity"
        case consumables
        case hyperdriveRating = "hyperdrive_rating"
        case mglt = "MGLT"
        case starshipClass = "starship_class"
        case pilots, films, created, edited, url
    }
    var imageURL: URL {
        URL(string: self.url)!
    }
}
struct StarshipProperty: Identifiable {
    let id = UUID().uuidString
    let name: String
    let value: String
}

extension Starship {
    var displayProperties: [StarshipProperty] {
        return [
            StarshipProperty(name:"Name", value:self.name),
            StarshipProperty(name:"Model", value:self.model ?? "N/A"),
            StarshipProperty(name:"Manufacturer", value:self.manufacturer ?? "N/A"),
            StarshipProperty(name:"Length", value:self.length ?? "N/A"),
            StarshipProperty(name:"Cost In Credits", value:self.costInCredits ?? "N/A"),
            StarshipProperty(name:"Max Atmosphering Speed", value:self.maxAtmospheringSpeed ?? "N/A"),
            StarshipProperty(name:"Cargo Capacity", value:self.cargoCapacity ?? "N/A"),
            StarshipProperty(name:"Hyper Drive Rating", value:self.hyperdriveRating ?? "N/A"),
            StarshipProperty(name:"Class", value:self.starshipClass ?? "N/A"),
            StarshipProperty(name:"Created", value:self.created?.date?.mediumDateStyle ?? "N/A")
        ]
    }
}

extension Starship: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

extension Array where Element == Starship {
    
    mutating func sortBy(option: StarshipSortOption) {
        switch option {
            case .nameAscending:
                self.sort { $0.name < $1.name}
            case .nameDescending:
                self.sort { $0.name > $1.name}
            case .lengthAscending:
                self.sort { $0.length?.floatValue ?? 0.0 < $1.length?.floatValue ?? 0.0}
            case .lengthDescending:
                self.sort { $0.length?.floatValue ?? 0.0 > $1.length?.floatValue ?? 0.0}
        }
    }
}

extension Starship {
    static let sampleData: [Starship] = [
        Starship(name: "CR90 corvette", model: "CR90 corvette", manufacturer: "Corellian Engineering Corporation", costInCredits: "12344", length: "150", maxAtmospheringSpeed: "650", crew: "", passengers: "", cargoCapacity: "", consumables: "", hyperdriveRating: "", mglt: "", starshipClass: "", pilots: [], films: [], created: "", edited: "", url: ""),
        Starship(name: "Star Destroyer", model: "Imperial I-class Star Destroyer", manufacturer: "Kuat Drive Yards", costInCredits: "12344", length: "150", maxAtmospheringSpeed: "650", crew: "", passengers: "", cargoCapacity: "", consumables: "", hyperdriveRating: "", mglt: "", starshipClass: "", pilots: [], films: [], created: "", edited: "", url: "")

    ]
}

enum StarshipSortOption: String {
    case nameAscending
    case nameDescending
    case lengthAscending
    case lengthDescending
}
