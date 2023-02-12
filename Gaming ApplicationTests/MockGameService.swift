//
//  MockGameService.swift
//  Gaming ApplicationTests
//
//  Created by murad on 12/02/2023.
//

import Foundation
@testable import Gaming_Application
class MockGameService: GameServiceType {
    
    func getGamesList(page: Int, search: String?, completion: @escaping ((NetworkRequestError?, GameListModel?) -> Void)) {
        if search == "nrf" {
            completion(NetworkRequestError.emptyData, nil)
        } else {
            let game1 = Game(id: 0, name: "GTA V", backgroundImage: "https://media.rawg.io/media/screenshots/40d/40dc4b5b0524efa25dab220ce2b93794.jpg", metacritic: 98, genres: [Genre(name: "Action"), Genre(name: "Comedy")])
            let game2 = Game(id: 1, name: "Life is Strange", backgroundImage: "https://media.rawg.io/media/games/562/562553814dd54e001a541e4ee83a591c.jpg", metacritic: 97, genres: [Genre(name: "adventure"), Genre(name: "Singleplayer")])
            
            let gameListModel = GameListModel(next: "", count: 20, results: [game1, game2])
            completion(nil, gameListModel)
        }
    }
    
    func getGameDetail(gameId: String, completion: @escaping ((NetworkRequestError?, GameDetailModel?) -> Void)) {
        if gameId.isEmpty {
            completion(NetworkRequestError.emptyData, nil)
        } else {
            let gameDetail = GameDetailModel(id: 0, name: "GTA V", description: "GTA V is a good Game", backgroundImage: "https://media.rawg.io/media/screenshots/40d/40dc4b5b0524efa25dab220ce2b93794.jpg", website: "gtaWebsite", redditURL: "gtaReddit")
            completion(nil, gameDetail)
        }
    }
    

   

}
