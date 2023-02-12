//
//  GameDetailModel.swift
//  Gaming Application
//
//  Created by murad on 09/02/2023.
//

import Foundation

// MARK: - GameDetailModel
struct GameDetailModel: Codable {
    let id: Int?
    let name, description: String?
    let backgroundImage: String?
    let website: String?
    let redditURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name, description, website
        case backgroundImage = "background_image"
        case redditURL = "reddit_url"
    }
}
