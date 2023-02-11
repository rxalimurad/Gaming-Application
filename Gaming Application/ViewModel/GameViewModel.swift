//
//  GameViewModel.swift
//  Gaming Application
//
//  Created by Ali Murad on 10/02/2023.
//

import Foundation
protocol GameViewModelDelegate: AnyObject {
    func updateUI(games: [Game]?)
    func showError(error: NetworkRequestError)
}


protocol GameViewModelType {
    var pageNumber: Int { get set}
    var delegate: GameViewModelDelegate? { get set}
    var hitInProgress: Bool { get set}
    var gamesList: [Game] { get set}
    init(service: GameServiceType)
    func getGamesListCount() -> Int
    func getGame(at: IndexPath) -> Game?
    func getGamesList(search: String?)
}


class GameViewModel: GameViewModelType {
    //MARK: - properties
    var hitInProgress = false
    var service: GameServiceType
    var pageNumber: Int = 1
    weak var delegate: GameViewModelDelegate?
    var gamesList: [Game] = [] {
        didSet {
            delegate?.updateUI(games: gamesList)
        }
    }
    //MARK: - Intializer
    required init(service: GameServiceType) {
        self.service = service
    }
    //MARK: - View Controller Helper
    func getGamesListCount() -> Int {
        self.gamesList.count
    }
    func getGame(at indexPath: IndexPath) -> Game? {
        return self.gamesList[indexPath.row]
    }
    //MARK: - Service Calls
    func getGamesList(search: String?) {
        hitInProgress = true
        service.getGamesList(page: self.pageNumber, search: search) {[weak self] error, gameModel in
            self?.hitInProgress = false
            if let error = error {
                self?.delegate?.showError(error: error)
            } else {
                if let gameModel = gameModel {
                    self?.gamesList.append(contentsOf: gameModel.results ?? [])
                }
            }
        }
    }
    
}
