//
//  Constants.swift
//  Gaming Application
//
//  Created by murad on 09/02/2023.
//

import Foundation

enum Constants {
    enum CellID {
        static let gameViewCell = "GameViewCell"
    }
    enum API {
        static let apiKey = "key"
        static let page = "page"
        static let pageSize = "page_size"
        static let search = "search"
    }
    enum Configuration {
        static let pageSize = "10"
        static let apiKeyValue = Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
    }
    enum UserDefaults {
        static let openedGames = "openedGames"
    }
    enum Views {
        static let storyboard = "Main"
        static let DetailView = "DetailView"
    }
    enum Color {
        static let openedColor = "openedColor"
    }
}
