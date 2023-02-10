//
//  GameViewModel.swift
//  Gaming Application
//
//  Created by Ali Murad on 10/02/2023.
//

import Foundation
protocol GameViewModelDelegate: AnyObject {
    func updateUI(games: [Game]?)
}


protocol GameViewModelType {
    var pageNumber: Int { get set}
    var service: GameServiceType { get set}
    var delegate: GameViewModelDelegate? { get set}
    var hitInProgress: Bool { get set}
    var gamesList: [Game] { get set}
    init(service: GameServiceType)
    func getGamesListCount() -> Int
    func getGame(at: IndexPath) -> Game?
    func getGamesList(search: String?)
}


class GameViewModel: GameViewModelType {
    var hitInProgress = false
    var service: GameServiceType
    var pageNumber: Int = 1
    weak var delegate: GameViewModelDelegate?
    var gamesList: [Game] = [] {
        didSet {
            delegate?.updateUI(games: gamesList)
        }
    }
    
    required init(service: GameServiceType) {
        self.service = service
    }
    
    func getGamesList(search: String?) {
        hitInProgress = true
        service.getGamesList(page: self.pageNumber, search: search) {[weak self] error, gameModel in
            self?.hitInProgress = false
            if let error = error {
                print(error)
            } else {
                if let gameModel = gameModel {
                    self?.gamesList.append(contentsOf: gameModel.results ?? [])
                }
            }
        }
    }
    func getGamesListCount() -> Int {
        self.gamesList.count
    }
    func getGame(at indexPath: IndexPath) -> Game? {
        return self.gamesList[indexPath.row]
    }
}
