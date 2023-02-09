//
//  GameListModel.swift
//  Gaming Application
//
//  Created by murad on 09/02/2023.
//

import Foundation

// MARK: - GameListModel
struct GameListModel: Codable {
    let next: String?
    let count: Int?
    let results: [Game]?
    //,,..
    
    static var new = GameListModel(next: nil, count: nil, results: [Game(id: 2, name: "Grand Theft Auto V", backgroundImage: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg", metacritic: 39, genres: [Genre(name: "action"), Genre(name: "thriller")])])
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
