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
    init(gameId: Int, service: GameServiceType)
    func fetchGameDetails()
    func getRedditUrl() -> URL?
    func getWebsiteUrl() -> URL?
}


class GameDetailsViewModel: GameDetailsViewModelType {
    //MARK: - Properties
    var gameId: String
    var service: GameServiceType
    var redditURL: URL?
    var websiteURL: URL?
    weak var delegate: GameDetailViewModelDelegate?
    
    //MARK: - Intializer
    required init(gameId: Int, service: GameServiceType) {
        self.gameId = "\(gameId)"
        self.service = service
    }
    
    //MARK: - View Controller Helper
    func getWebsiteUrl() -> URL? {
        return websiteURL
    }
    func getRedditUrl() -> URL? {
        return redditURL
    }
    
    //MARK: - Service Calls
    func fetchGameDetails() {
        service.getGameDetail(gameId: gameId) {[weak self] error, model in
            if let error = error {
                self?.delegate?.showError(error: error)
            } else {
                if let model = model {
                    self?.redditURL = URL(string: model.redditURL ?? "")
                    self?.websiteURL = URL(string: model.website ?? "")
                    self?.delegate?.updateUI(with: model)
                }
            }
        }
    }
  
}
