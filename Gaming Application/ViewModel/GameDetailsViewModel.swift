//
//  GameDetailsViewModel.swift
//  Gaming Application
//
//  Created by Ali Murad on 11/02/2023.
//

import Foundation

protocol GameDetailViewModelDelegate: AnyObject {
    func updateUI(with gameDetail: GameDetailModel)
    func showError(error: NetworkRequestError)
}

protocol GameDetailsViewModelType {
    var delegate: GameDetailViewModelDelegate? { get set }
    init(game: Game, service: GameServiceType, localDBHandler: LocalDBHandler)
    func fetchGameDetails()
    func getRedditUrl() -> URL?
    func getWebsiteUrl() -> URL?
    func removeFromFavourite()
    func addToFavourite()
    func isFavourite() -> Bool
}

class GameDetailsViewModel: GameDetailsViewModelType {
    // MARK: - Properties
    var game: Game
    var gameDetail: GameDetailModel?
    var service: GameServiceType
    var localDBHandler: LocalDBHandler
    var redditURL: URL?
    var websiteURL: URL?
    weak var delegate: GameDetailViewModelDelegate?

    // MARK: - Intializer
    required init(game: Game, service: GameServiceType, localDBHandler: LocalDBHandler) {
        self.game = game
        self.service = service
        self.localDBHandler = localDBHandler
    }

    // MARK: - View Controller Helper
    func getWebsiteUrl() -> URL? {
        return websiteURL
    }
    func getRedditUrl() -> URL? {
        return redditURL
    }
    func addToFavourite() {
        localDBHandler.saveGame(data: self.game)
    }
    func isFavourite() -> Bool {
        guard let id = game.id else { return false }
        return localDBHandler.isGameExist(id: id)
    }
    func removeFromFavourite() {
        guard let id = game.id else { return }
        if let coreGame = localDBHandler.getGame(id: id) {
            localDBHandler.removeGame(game: coreGame)
        }
    }

    // MARK: - Service Calls
    func fetchGameDetails() {
        guard let gameId = game.id else {
            self.delegate?.showError(error: NetworkRequestError.emptyData)
            return
        }
        service.getGameDetail(gameId: "\(gameId)") {[weak self] error, model in
            if let error = error {
                self?.delegate?.showError(error: error)
            } else {
                if let model = model {
                    self?.redditURL = URL(string: model.redditURL ?? "")
                    self?.websiteURL = URL(string: model.website ?? "")
                    self?.gameDetail = model
                    self?.delegate?.updateUI(with: model)
                }
            }
        }
    }
}
