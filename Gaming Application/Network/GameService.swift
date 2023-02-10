//
//  GameService.swift
//  Gaming Application
//
//  Created by murad on 09/02/2023.
//

import Foundation

protocol GameServiceType {
    func getGamesList(page: Int, search: String?, completion: @escaping((NetworkRequestError?, GameListModel?) -> Void))

}

final class GameService: GameServiceType {
    private let apiClient: APIClientType
    
    init(apiClient: APIClientType = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getGamesList(page: Int, search: String?, completion: @escaping((NetworkRequestError?, GameListModel?) -> Void)) {
        let queryItems = [Constants.API.apiKey : Constants.Configuration.apiKeyValue,
                          Constants.API.page: "\(page)",
                          Constants.API.search: search,
                          Constants.API.pageSize: Constants.Configuration.pageSize
        ]
        let req = Endpoint(urlPostfix: nil,
                           method: .get,
                           queryItems: queryItems
        )
        apiClient.request(endPoint: req, completion: completion)
    }
    
    
}
