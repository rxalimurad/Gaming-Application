//
//  FavouriteViewModelTests.swift
//  Gaming ApplicationTests
//
//  Created by murad on 13/02/2023.
//

import XCTest
@testable import Gaming_Application
class FavouriteViewModelTests: XCTestCase {
    var sut: FavouriteViewModelType?
    var localDBHandler: LocalDBHandler?
    override func setUpWithError() throws {
        localDBHandler = CoreDataHandler()
        if let localDBHandler = localDBHandler {
            sut = FavouriteViewModel(localDBHandler: localDBHandler)
        }
        let game1 = Game(id: 0, name: "GTA V", backgroundImage: "https://media.rawg.io/media/screenshots/40d/40dc4b5b0524efa25dab220ce2b93794.jpg", metacritic: 98, genres: [Genre(name: "Action"), Genre(name: "Comedy")])
        let game2 = Game(id: 1, name: "Life is Strange", backgroundImage: "https://media.rawg.io/media/games/562/562553814dd54e001a541e4ee83a591c.jpg", metacritic: 97, genres: [Genre(name: "adventure"), Genre(name: "Singleplayer")])
        localDBHandler?.deleteAllData()
        localDBHandler?.saveGame(data: game1)
        localDBHandler?.saveGame(data: game2)
        
        
        
    }

    override func tearDownWithError() throws {
        localDBHandler = nil
        sut = nil
    }

    func testFavouriteList() throws {
        sut?.fetchFavGameList()
        XCTAssertEqual(sut?.getNumberOfGames(), 2)
        XCTAssertEqual(sut?.getFavGame(at: IndexPath(row: 1, section: 0)).name, "Life is Strange")
        XCTAssertEqual(sut?.getFavGame(at: IndexPath(row: 1, section: 0)).metacritic, 97)
        sut?.removeFav(from: IndexPath(row: 0, section: 0))
        XCTAssertEqual(sut?.getNumberOfGames(), 1)
        sut?.removeFav(from: IndexPath(row: 0, section: 0))
        XCTAssertEqual(sut?.getNumberOfGames(), 0)
    }

}
