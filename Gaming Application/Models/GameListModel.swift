//
//  GameListModel.swift
//  Gaming Application
//
//  Created by murad on 09/02/2023.
//

import Foundation
import CoreData
// MARK: - GameListModel
struct GameListModel: Codable {
    let next: String?
    let count: Int?
    let results: [Game]?
    static var new = GameListModel(next: nil, count: nil, results: nil)
}

// MARK: - ResultObj
struct Game: Codable {
    let id: Int?
    let name: String?
    let backgroundImage: String?
    let metacritic: Int?
    let genres: [Genre]?

    enum CodingKeys: String, CodingKey {
        case id, name, metacritic, genres
        case backgroundImage = "background_image"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let name: String?
}
