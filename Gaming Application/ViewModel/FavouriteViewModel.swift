//
//  FavouriteViewModel.swift
//  Gaming Application
//
//  Created by murad on 12/02/2023.
//

import Foundation
protocol FavouriteViewModelDelegate: AnyObject {
    func reloadData()
}

protocol FavouriteViewModelType {
    var delegate: FavouriteViewModelDelegate? { get set }
    init(localDBHandler: LocalDBHandler)
    func fetchFavGameList()
    func getNumberOfGames() -> Int
    func getFavGame(at indexPath: IndexPath) -> Game
    func removeFav(from indexPath: IndexPath)
}

class FavouriteViewModel: FavouriteViewModelType {
    // MARK: - Properties
    weak var delegate: FavouriteViewModelDelegate?
    var games: [Game] = []
    var localDBHandler: LocalDBHandler
    // MARK: - Intializer
    required init(localDBHandler: LocalDBHandler) {
        self.localDBHandler = localDBHandler
    }
    // MARK: - Data fetching
    func fetchFavGameList() {
        games = localDBHandler.getFavGames()
    }
    func removeFav(from indexPath: IndexPath) {
        guard let id = games[indexPath.row].id else { return }
        guard let gameInfo = localDBHandler.getGame(id: id) else { return }
        games.remove(at: indexPath.row)
        localDBHandler.removeGame(game: gameInfo)
    }
    // MARK: - View Controller helper
    func getNumberOfGames() -> Int {
        games.count
    }

    func getFavGame(at indexPath: IndexPath) -> Game {
        games[indexPath.row]
    }
}
